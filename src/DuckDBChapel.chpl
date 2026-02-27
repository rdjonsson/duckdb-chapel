module DuckDBChapel {
  include module DuckDBCAPI;
  use DuckDBCAPI;
  use CTypes;
  use Reflection;
  use Map;
  use List;

  // ============================================
  // Exception
  // ============================================

  class DuckDBException: Error {
    var msg: string;
    proc init(msg: string) {
      this.msg = msg;
    }
    override proc message(): string {
      return msg;
    }
  }

  // ============================================
  // Column Type Enum (Chapel-level storage types)
  // ============================================

  enum ColumnType {
    BOOL,
    INT64,
    DOUBLE,
    VARCHAR,
    UNKNOWN
  }

  // ============================================
  // DuckDBColumn - a single typed column
  // ============================================

  record DuckDBColumn {
    var name: string;
    var dtype: ColumnType;
    var srcType: duckdb_type;

    // Storage - only one is populated based on dtype
    var boolValues:   list(bool);
    var intValues:    list(int(64));
    var doubleValues: list(real(64));
    var stringValues: list(string);
    var nullMask:     list(bool);

    proc init() { }

    proc init(name: string, dtype: ColumnType, srcType: duckdb_type) {
      this.name = name;
      this.dtype = dtype;
      this.srcType = srcType;
    }

    proc const size: int { return nullMask.size; }

    proc const isNull(row: int): bool { return nullMask[row]; }

    // Direct value access by row
    proc const getInt(row: int): int(64)  { return intValues[row]; }
    proc const getDouble(row: int): real(64) { return doubleValues[row]; }
    proc const getString(row: int): string { return stringValues[row]; }
    proc const getBool(row: int): bool   { return boolValues[row]; }

    // Return entire column as an array
    proc const toIntArray(): [] int(64) {
      var arr: [0..<intValues.size] int(64);
      for i in arr.domain do arr[i] = intValues[i];
      return arr;
    }

    proc const toDoubleArray(): [] real(64) {
      var arr: [0..<doubleValues.size] real(64);
      for i in arr.domain do arr[i] = doubleValues[i];
      return arr;
    }

    proc const toStringArray(): [] string {
      var arr: [0..<stringValues.size] string;
      for i in arr.domain do arr[i] = stringValues[i];
      return arr;
    }

    proc const toBoolArray(): [] bool {
      var arr: [0..<boolValues.size] bool;
      for i in arr.domain do arr[i] = boolValues[i];
      return arr;
    }
  }

  // ============================================
  // DuckDBDataframe - a collection of typed,
  // named columns
  // ============================================

  record DuckDBDataframe {
    var _columns:   list(DuckDBColumn);
    var _nameToIdx: map(string, int);
    var _numRows: int = 0;
    var _numCols: int = 0;

    proc init() { }

    proc const numRows(): int { return _numRows; }
    proc const numCols(): int { return _numCols; }

    // Column names
    proc const columnNames(): [] string {
      var names: [0..<_numCols] string;
      for i in 0..<_numCols do names[i] = _columns[i].name;
      return names;
    }

    // Column types
    proc const columnTypes(): [] ColumnType {
      var types: [0..<_numCols] ColumnType;
      for i in 0..<_numCols do types[i] = _columns[i].dtype;
      return types;
    }

    // ----------------------------------------
    // Column access by index
    // ----------------------------------------
    proc const ref column(idx: int): DuckDBColumn {
      return _columns[idx];
    }

    // ----------------------------------------
    // Column access by name
    // ----------------------------------------
    proc const ref column(name: string): DuckDBColumn throws {
      if !_nameToIdx.contains(name) {
        throw new DuckDBException("Column not found: " + name);
      }
      return _columns[_nameToIdx[name]];
    }

    // ----------------------------------------
    // Typed column array accessors by index
    // ----------------------------------------
    proc const getIntColumn(idx: int): [] int(64) {
      return _columns[idx].toIntArray();
    }

    proc const getDoubleColumn(idx: int): [] real(64) {
      return _columns[idx].toDoubleArray();
    }

    proc const getStringColumn(idx: int): [] string {
      return _columns[idx].toStringArray();
    }

    proc const getBoolColumn(idx: int): [] bool {
      return _columns[idx].toBoolArray();
    }

    // ----------------------------------------
    // Typed column array accessors by name
    // ----------------------------------------
    proc const getIntColumn(name: string): [] int(64) throws {
      return column(name).toIntArray();
    }

    proc const getDoubleColumn(name: string): [] real(64) throws {
      return column(name).toDoubleArray();
    }

    proc const getStringColumn(name: string): [] string throws {
      return column(name).toStringArray();
    }

    proc const getBoolColumn(name: string): [] bool throws {
      return column(name).toBoolArray();
    }

    // ----------------------------------------
    // Cell access (col, row) by name
    // ----------------------------------------
    proc const isNull(colName: string, row: int): bool throws {
      return column(colName).isNull(row);
    }
  }

  // ============================================
  // Database
  // ============================================

  record Database {
    var _db: duckdb_database;
    var _valid: bool = false;
    proc init() { }
    proc ref deinit() {
      if _valid then duckdb_close(this._db);
    }
  }

  proc openDatabase(path: string = ":memory:"): Database throws {
    var db: Database;
    var state = duckdb_open(path.c_str(), db._db);
    if state != DuckDBSuccess {
      throw new DuckDBException("Failed to open database: " + path);
    }
    db._valid = true;
    return db;
  }

  // ============================================
  // Connection
  // ============================================

  record Connection {
    var _conn: duckdb_connection;
    var _valid: bool = false;
    proc init() { }
    proc ref deinit() {
      if _valid then duckdb_disconnect(this._conn);
    }

    proc ref execute(query: string): QueryResult throws {
      return executeQuery(this, query);
    }

    proc ref fetchAll(type T, query: string): [] T throws {
      var result = executeQuery(this, query);
      return result.toArray(T);
    }

    proc ref fetchAllMapped(type T, query: string,
                            mapping: [] (string, string)): [] T throws {
      var result = executeQuery(this, query);
      return result.toArrayMapped(T, mapping);
    }

    // Return query results as a DuckDBDataframe
    proc ref queryToDataframe(query: string): DuckDBDataframe throws {
      var result = executeQuery(this, query);
      return buildDataframe(result);
    }
  }

  proc connect(ref db: Database): Connection throws {
    var conn: Connection;
    var state = duckdb_connect(db._db, conn._conn);
    if state != DuckDBSuccess {
      throw new DuckDBException("Failed to create connection");
    }
    conn._valid = true;
    return conn;
  }

  // ============================================
  // QueryResult
  // ============================================

  record QueryResult {
    var _result: duckdb_result;
    var _valid: bool = false;

    proc init() { }
    proc ref deinit() {
      if _valid then duckdb_destroy_result(this._result);
    }

    proc ref columnCount(): int {
      return duckdb_column_count(this._result): int;
    }

    proc ref rowCount(): int {
      return duckdb_row_count(this._result): int;
    }

    proc ref columnName(col: int): string throws {
      var cstr = duckdb_column_name(this._result, col: idx_t);
      if cstr == nil then throw new DuckDBException("Failed to get column name");
      return string.createCopyingBuffer(cstr);
    }

    proc ref getColumnMap(): map(string, int) throws {
      var colMap: map(string, int);
      for col in 0..<columnCount() {
        colMap[columnName(col)] = col;
      }
      return colMap;
    }

    // Positional record mapping
    proc ref toArray(type T): [] T throws {
      var items: list(T);

      while true {
        var chunk = duckdb_fetch_chunk(this._result);
        if chunk == nil then break;

        var chunkSize = duckdb_data_chunk_get_size(chunk): int;
        if chunkSize == 0 {
          duckdb_destroy_data_chunk(chunk);
          break;
        }

        for localRow in 0..<chunkSize {
          var rec: T;
          populateFromChunkByPosition(rec, chunk, localRow);
          items.pushBack(rec);
        }
        duckdb_destroy_data_chunk(chunk);
      }

      var arr: [0..<items.size] T;
      for i in 0..<items.size do arr[i] = items[i];
      return arr;
    }

    // Named record mapping
    proc ref toArrayMapped(type T,
                           mapping: [] (string, string)): [] T throws {
      var colMap = getColumnMap();
      var fieldToCol: map(string, int);
      for (colName, fieldName) in mapping {
        if colMap.contains(colName) {
          fieldToCol[fieldName] = colMap[colName];
        }
      }

      var items: list(T);

      while true {
        var chunk = duckdb_fetch_chunk(this._result);
        if chunk == nil then break;

        var chunkSize = duckdb_data_chunk_get_size(chunk): int;
        if chunkSize == 0 {
          duckdb_destroy_data_chunk(chunk);
          break;
        }

        for localRow in 0..<chunkSize {
          var rec: T;
          populateFromChunkByName(rec, chunk, localRow, fieldToCol);
          items.pushBack(rec);
        }
        duckdb_destroy_data_chunk(chunk);
      }

      var arr: [0..<items.size] T;
      for i in 0..<items.size do arr[i] = items[i];
      return arr;
    }
  }

  // ============================================
  // Dataframe Builder
  // ============================================

  private proc mapColumnType(srcType: duckdb_type): ColumnType {
    if srcType == DUCKDB_TYPE_BOOLEAN  then return ColumnType.BOOL;
    if srcType == DUCKDB_TYPE_TINYINT  ||
       srcType == DUCKDB_TYPE_SMALLINT ||
       srcType == DUCKDB_TYPE_INTEGER  ||
       srcType == DUCKDB_TYPE_BIGINT   then return ColumnType.INT64;
    if srcType == DUCKDB_TYPE_FLOAT ||
       srcType == DUCKDB_TYPE_DOUBLE   then return ColumnType.DOUBLE;
    if srcType == DUCKDB_TYPE_VARCHAR  then return ColumnType.VARCHAR;
    return ColumnType.UNKNOWN;
  }

  private proc buildDataframe(ref result: QueryResult): DuckDBDataframe throws {
    var df: DuckDBDataframe;
    var nCols = result.columnCount();
    df._numCols = nCols;

    // Initialize columns with names and types
    for col in 0..<nCols {
      var colName = result.columnName(col);
      var srcType = duckdb_column_type(result._result, col: idx_t);
      var dtype   = mapColumnType(srcType);

      var column = new DuckDBColumn(colName, dtype, srcType);
      df._columns.pushBack(column);
      df._nameToIdx[colName] = col;
    }

    // Stream chunks and populate columns
    while true {
      var chunk = duckdb_fetch_chunk(result._result);
      if chunk == nil then break;

      var chunkSize = duckdb_data_chunk_get_size(chunk): int;
      if chunkSize == 0 {
        duckdb_destroy_data_chunk(chunk);
        break;
      }

      for col in 0..<nCols {
        var vector   = duckdb_data_chunk_get_vector(chunk, col: idx_t);
        var dataPtr  = duckdb_vector_get_data(vector);
        var validity = duckdb_vector_get_validity(vector);

        for row in 0..<chunkSize {
          var isNull = (validity != nil &&
                        !duckdb_validity_row_is_valid(validity, row: idx_t));

          df._columns[col].nullMask.pushBack(isNull);

          if isNull {
            appendDefaultValue(df._columns[col]);
          } else {
            appendValueFromVector(df._columns[col], dataPtr, row);
          }
        }
      }

      df._numRows += chunkSize;
      duckdb_destroy_data_chunk(chunk);
    }

    return df;
  }

  // Append a typed value from a vector into a column
  private proc appendValueFromVector(ref col: DuckDBColumn,
                                      dataPtr: c_ptr(void),
                                      row: int) throws {
    select col.dtype {
      when ColumnType.BOOL {
        col.boolValues.pushBack(
          ((dataPtr: c_ptr(uint(8))) + row).deref() != 0);
      }
      when ColumnType.INT64 {
        if col.srcType == DUCKDB_TYPE_TINYINT {
          col.intValues.pushBack(
            ((dataPtr: c_ptr(int(8))) + row).deref(): int(64));
        } else if col.srcType == DUCKDB_TYPE_SMALLINT {
          col.intValues.pushBack(
            ((dataPtr: c_ptr(int(16))) + row).deref(): int(64));
        } else if col.srcType == DUCKDB_TYPE_INTEGER {
          col.intValues.pushBack(
            ((dataPtr: c_ptr(int(32))) + row).deref(): int(64));
        } else {
          col.intValues.pushBack(
            ((dataPtr: c_ptr(int(64))) + row).deref());
        }
      }
      when ColumnType.DOUBLE {
        if col.srcType == DUCKDB_TYPE_FLOAT {
          col.doubleValues.pushBack(
            ((dataPtr: c_ptr(real(32))) + row).deref(): real(64));
        } else {
          col.doubleValues.pushBack(
            ((dataPtr: c_ptr(real(64))) + row).deref());
        }
      }
      when ColumnType.VARCHAR {
        col.stringValues.pushBack(extractDuckDBString(dataPtr, row));
      }
      otherwise { }
    }
  }

  // Append a default/zero value for null cells (keeps indices aligned)
  private proc appendDefaultValue(ref col: DuckDBColumn) {
    select col.dtype {
      when ColumnType.BOOL    do col.boolValues.pushBack(false);
      when ColumnType.INT64   do col.intValues.pushBack(0);
      when ColumnType.DOUBLE  do col.doubleValues.pushBack(0.0);
      when ColumnType.VARCHAR do col.stringValues.pushBack("");
      otherwise { }
    }
  }

  // ============================================
  // Chunk-based record population helpers
  // ============================================

  private proc populateFromChunkByPosition(ref rec: ?T,
                                            chunk: duckdb_data_chunk,
                                            localRow: int) throws {
    param numFields = Reflection.getNumFields(T);
    for param fieldIdx in 0..<numFields {
      const col = fieldIdx;
      var vector   = duckdb_data_chunk_get_vector(chunk, col: idx_t);
      var validity = duckdb_vector_get_validity(vector);

      if validity != nil &&
         !duckdb_validity_row_is_valid(validity, localRow: idx_t) {
        continue;
      }

      var dataPtr = duckdb_vector_get_data(vector);
      setFieldFromVector(rec, fieldIdx, dataPtr, localRow);
    }
  }

  private proc populateFromChunkByName(ref rec: ?T,
                                        chunk: duckdb_data_chunk,
                                        localRow: int,
                                        fieldToCol: map(string, int)) throws {
    param numFields = Reflection.getNumFields(T);
    for param fieldIdx in 0..<numFields {
      param fieldName = Reflection.getFieldName(T, fieldIdx);

      if !fieldToCol.contains(fieldName) then continue;

      const col    = fieldToCol[fieldName];
      var vector   = duckdb_data_chunk_get_vector(chunk, col: idx_t);
      var validity = duckdb_vector_get_validity(vector);

      if validity != nil &&
         !duckdb_validity_row_is_valid(validity, localRow: idx_t) {
        continue;
      }

      var dataPtr = duckdb_vector_get_data(vector);
      setFieldFromVector(rec, fieldIdx, dataPtr, localRow);
    }
  }

  // ============================================
  // Type-dispatched field setter
  // ============================================

  private proc setFieldFromVector(ref rec: ?T, param fieldIdx: int,
                                   dataPtr: c_ptr(void), localRow: int) throws{
    ref field = Reflection.getFieldRef(rec, fieldIdx);
    type FT = field.type;

    if FT == bool {
      field = ((dataPtr: c_ptr(uint(8))) + localRow).deref() != 0;
    } else if FT == int(8) {
      field = ((dataPtr: c_ptr(int(8)))  + localRow).deref();
    } else if FT == int(16) {
      field = ((dataPtr: c_ptr(int(16))) + localRow).deref();
    } else if FT == int(32) {
      field = ((dataPtr: c_ptr(int(32))) + localRow).deref();
    } else if FT == int || FT == int(64) {
      field = ((dataPtr: c_ptr(int(64))) + localRow).deref(): FT;
    } else if FT == real(32) {
      field = ((dataPtr: c_ptr(real(32))) + localRow).deref();
    } else if FT == real || FT == real(64) {
      field = ((dataPtr: c_ptr(real(64))) + localRow).deref(): FT;
    } else if FT == string {
      field = extractDuckDBString(dataPtr, localRow);
    }
  }

  // ============================================
  // DuckDB string extraction
  //
  // duckdb_string_t layout (16 bytes):
  //   bytes 0..3  : uint32 length
  //   If length <= 12  (inlined):
  //     bytes 4..15 : string data
  //   If length > 12   (pointer):
  //     bytes 4..7  : 4-byte prefix
  //     bytes 8..15 : char* to heap data
  // ============================================

private proc extractDuckDBString(dataPtr: c_ptr(void),
                                  row: int): string throws {
  const STRING_T_SIZE = 16;
  const INLINE_LIMIT  = 12;

  // Byte pointer for offset arithmetic
  var base   = (dataPtr: c_ptr(uint(8))) + (row * STRING_T_SIZE);

  // Read length (uint32) — cast through void
  var length = (base: c_ptr(void): c_ptr(uint(32))).deref();

  if length == 0 then return "";

  var srcPtr: c_ptrConst(c_char);
  if length <= INLINE_LIMIT: uint(32) {
    // Inlined: data starts at offset 4 — cast through void
    srcPtr = (base + 4): c_ptr(void): c_ptrConst(c_char);
  } else {
    // Pointer-based: an 8-byte pointer sits at offset 8 — cast through void
    srcPtr = ((base + 8): c_ptr(void): c_ptr(c_ptrConst(c_char))).deref();
  }

  return string.createCopyingBuffer(srcPtr, length = length: int);
}


  // ============================================
  // Query execution factory
  // ============================================

  proc executeQuery(ref conn: Connection, query: string): QueryResult throws {
    var result: QueryResult;
    var state = duckdb_query(conn._conn, query.c_str(), result._result);
    if state != DuckDBSuccess {
      var errMsg = string.createCopyingBuffer(
                     duckdb_result_error(result._result));
      duckdb_destroy_result(result._result);
      throw new DuckDBException("Query failed: " + errMsg);
    }
    result._valid = true;
    return result;
  }
}

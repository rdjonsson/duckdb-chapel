module DuckDB {
  public use DuckDBCAPI;
  use CTypes;
  use Reflection;
  use Map;

  // ============================================
  // Exception Class
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
  // Database Record
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
  // Connection Record
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

    proc ref fetchAllMapped(type T, query: string, mapping: [] (string, string)): [] T throws {
      var result = executeQuery(this, query);
      return result.toArrayMapped(T, mapping);
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
  // QueryResult Record
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
      return string.createCopyingBuffer(cstr);
    }

    proc getColumnMap(): map(string, int) throws{
      var colMap: map(string, int);
      for col in 0..<columnCount() {
        colMap[columnName(col)] = col;
      }
      return colMap;
    }

    proc ref getInt32(col: int, row: int): int(32) {
      return duckdb_value_int32(this._result, col: idx_t, row: idx_t);
    }

    proc ref getInt64(col: int, row: int): int(64) {
      return duckdb_value_int64(this._result, col: idx_t, row: idx_t);
    }

    proc ref getDouble(col: int, row: int): real(64) {
      return duckdb_value_double(this._result, col: idx_t, row: idx_t);
    }

    proc getString(col: int, row: int): string {
      var cstr = duckdb_value_varchar(this._result, col: idx_t, row: idx_t);
      var str = string.createCopyingBuffer(cstr);
      duckdb_free(cstr: c_ptr(void));
      return str;
    }

    proc getBool(col: int, row: int): bool {
      return duckdb_value_boolean(this._result, col: idx_t, row: idx_t);
    }

    proc isNull(col: int, row: int): bool {
      return duckdb_value_is_null(this._result, col: idx_t, row: idx_t);
    }

    // ==========================================
    // Record Mapping - Positional
    // ==========================================

    proc ref toArray(type T): [] T throws {
      var arr: [0..<rowCount()] T;

      for row in 0..<rowCount() {
        populateByPosition(arr[row], row);
      }

      return arr;
    }

    // Populate record by position: column i -> field i
    proc populateByPosition(ref rec: ?T, row: int) throws {
      param numFields = Reflection.getNumFields(T);

      // Use param loop - unrolls at compile time
      for param fieldIdx in 0..<numFields {
        const col = fieldIdx;  // Positional: field i = column i

        if col >= columnCount() {
          throw new DuckDBException(
            "Record has more fields (" + numFields:string + 
            ") than query columns (" + columnCount():string + ")");
        }

        if !isNull(col, row) {
          setFieldByIndex(rec, fieldIdx, col, row);
        }
      }
    }

    // Helper: Set a specific field (param index) from a column (runtime index)
    proc setFieldByIndex(ref rec: ?T, param fieldIdx: int, col: int, row: int) {
      ref field = Reflection.getFieldRef(rec, fieldIdx);
      type FieldType = field.type;

      if FieldType == int || FieldType == int(64) {
        field = getInt64(col, row): FieldType;
      } else if FieldType == int(32) {
        field = getInt32(col, row);
      } else if FieldType == real || FieldType == real(64) {
        field = getDouble(col, row): FieldType;
      } else if FieldType == real(32) {
        field = getDouble(col, row): FieldType;
      } else if FieldType == string {
        field = getString(col, row);
      } else if FieldType == bool {
        field = getBool(col, row);
      }
    }

    // ==========================================
    // Record Mapping - By Name
    // ==========================================

    proc toArrayMapped(type T, mapping: [] (string, string)): [] T throws {
      // Build column name -> column index map
      var colMap = getColumnMap();

      // Build field name -> column index map
      var fieldToCol: map(string, int);
      for (colName, fieldName) in mapping {
        if colMap.contains(colName) {
          fieldToCol[fieldName] = colMap[colName];
        }
      }

      var arr: [0..<rowCount()] T;

      for row in 0..<rowCount() {
        populateByName(arr[row], row, fieldToCol);
      }

      return arr;
    }

    // Populate record by field name mapping
    proc populateByName(ref rec: ?T, row: int, fieldToCol: map(string, int)) throws {
      param numFields = Reflection.numFields(T);

      // Param loop unrolls at compile time
      for param fieldIdx in 0..<numFields {
        param fieldName = Reflection.getFieldName(T, fieldIdx);

        // Runtime check if this field has a mapping
        if fieldToCol.contains(fieldName) {
          const col = fieldToCol[fieldName];

          if !isNull(col, row) {
            setFieldByIndex(rec, fieldIdx, col, row);
          }
        }
      }
    }
  }

  proc executeQuery(ref conn: Connection, query: string): QueryResult throws {
    var result: QueryResult;
    var state = duckdb_query(conn._conn, query.c_str(), result._result);
    if state != DuckDBSuccess {
      var errMsg = string.createCopyingBuffer(duckdb_result_error(result._result));
      duckdb_destroy_result(result._result);
      throw new DuckDBException("Query failed: " + errMsg);
    }
    result._valid = true;
    return result;
  }
}

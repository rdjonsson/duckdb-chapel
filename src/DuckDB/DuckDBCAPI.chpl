module DuckDBCAPI {
  use CTypes;

  // Ensure duckdb.h is included during C compilation
  require "duckdb.h";
  require "-lduckdb";

  // ============================================
  // Opaque Handle Types
  // ============================================

  extern "duckdb_database"   type duckdb_database;
  extern "duckdb_connection" type duckdb_connection;
  extern "duckdb_result"     type duckdb_result;
  extern "duckdb_prepared_statement" type duckdb_prepared_statement;

  // Data Chunk API handle types (void* in C)
  extern "duckdb_data_chunk"   type duckdb_data_chunk = c_ptr(void);
  extern "duckdb_vector"       type duckdb_vector = c_ptr(void);
  extern "duckdb_logical_type" type duckdb_logical_type = c_ptr(void);

  // ============================================
  // Enum / Constant Types
  // ============================================

  extern "duckdb_state" type duckdb_state = c_int;
  extern const DuckDBSuccess: duckdb_state;
  extern const DuckDBError: duckdb_state;

  extern "duckdb_type" type duckdb_type = c_int;
  extern const DUCKDB_TYPE_INVALID:  duckdb_type;
  extern const DUCKDB_TYPE_BOOLEAN:  duckdb_type;
  extern const DUCKDB_TYPE_TINYINT:  duckdb_type;
  extern const DUCKDB_TYPE_SMALLINT: duckdb_type;
  extern const DUCKDB_TYPE_INTEGER:  duckdb_type;
  extern const DUCKDB_TYPE_BIGINT:   duckdb_type;
  extern const DUCKDB_TYPE_FLOAT:    duckdb_type;
  extern const DUCKDB_TYPE_DOUBLE:   duckdb_type;
  extern const DUCKDB_TYPE_VARCHAR:  duckdb_type;

  extern "idx_t" type idx_t = uint(64);

  // ============================================
  // Database Lifecycle
  // ============================================

  extern proc duckdb_open(path: c_ptrConst(c_char),
                          ref database: duckdb_database): duckdb_state;
  extern proc duckdb_close(ref database: duckdb_database): void;

  // ============================================
  // Connection
  // ============================================

  extern proc duckdb_connect(database: duckdb_database,
                             ref connection: duckdb_connection): duckdb_state;
  extern proc duckdb_disconnect(ref connection: duckdb_connection): void;

  // ============================================
  // Query Execution
  // ============================================

  extern proc duckdb_query(connection: duckdb_connection,
                           query: c_ptrConst(c_char),
                           ref result: duckdb_result): duckdb_state;
  extern proc duckdb_destroy_result(ref result: duckdb_result): void;

  // ============================================
  // Result Metadata
  // ============================================

  extern proc duckdb_column_count(ref result: duckdb_result): idx_t;
  extern proc duckdb_row_count(ref result: duckdb_result): idx_t;
  extern proc duckdb_column_name(ref result: duckdb_result,
                                  col: idx_t): c_ptrConst(c_char);
  extern proc duckdb_column_type(ref result: duckdb_result,
                                  col: idx_t): duckdb_type;
  extern proc duckdb_result_error(ref result: duckdb_result): c_ptrConst(c_char);

  // ============================================
  // Data Chunk API (non-deprecated)
  // ============================================

  // Fetch the next data chunk from a result. Returns nil when exhausted.
  extern proc duckdb_fetch_chunk(result: duckdb_result): duckdb_data_chunk;
  extern proc duckdb_destroy_data_chunk(ref chunk: duckdb_data_chunk): void;
  extern proc duckdb_data_chunk_get_size(chunk: duckdb_data_chunk): idx_t;
  extern proc duckdb_data_chunk_get_column_count(chunk: duckdb_data_chunk): idx_t;
  extern proc duckdb_data_chunk_get_vector(chunk: duckdb_data_chunk,
                                            col_idx: idx_t): duckdb_vector;

  // ============================================
  // Vector API (non-deprecated)
  // ============================================

  extern proc duckdb_vector_get_data(vector: duckdb_vector): c_ptr(void);
  extern proc duckdb_vector_get_validity(vector: duckdb_vector): c_ptr(uint(64));
  extern proc duckdb_vector_get_column_type(vector: duckdb_vector): duckdb_logical_type;
  extern proc duckdb_vector_size(): idx_t;

  // ============================================
  // Validity Helpers
  // ============================================

  extern proc duckdb_validity_row_is_valid(validity: c_ptr(uint(64)),
                                            row: idx_t): bool;

  // ============================================
  // Logical Type
  // ============================================

  extern proc duckdb_get_type_id(logicalType: duckdb_logical_type): duckdb_type;
  extern proc duckdb_destroy_logical_type(ref logicalType: duckdb_logical_type): void;

  // ============================================
  // Memory Management
  // ============================================

  extern proc duckdb_free(ptr: c_ptr(void)): void;

  // ============================================
  // Prepared Statements
  // ============================================

  extern proc duckdb_prepare(connection: duckdb_connection,
                              query: c_ptrConst(c_char),
                              ref out_prepared_statement: duckdb_prepared_statement): duckdb_state;
  extern proc duckdb_destroy_prepare(ref prepared_statement: duckdb_prepared_statement): void;
  extern proc duckdb_execute_prepared(prepared_statement: duckdb_prepared_statement,
                                       ref out_result: duckdb_result): duckdb_state;

  extern "duckdb_bind_int32"
  proc duckdb_bind_int32(prepared_statement: duckdb_prepared_statement,
                         bindIdx: idx_t, val: int(32)): duckdb_state;
  extern "duckdb_bind_int64"
  proc duckdb_bind_int64(prepared_statement: duckdb_prepared_statement,
                         bindIdx: idx_t, val: int(64)): duckdb_state;
  extern "duckdb_bind_double"
  proc duckdb_bind_double(prepared_statement: duckdb_prepared_statement,
                          bindIdx: idx_t, val: real(64)): duckdb_state;
  extern "duckdb_bind_varchar"
  proc duckdb_bind_varchar(prepared_statement: duckdb_prepared_statement,
                           bindIdx: idx_t, val: c_ptrConst(c_char)): duckdb_state;
  extern "duckdb_bind_boolean"
  proc duckdb_bind_boolean(prepared_statement: duckdb_prepared_statement,
                           bindIdx: idx_t, val: bool): duckdb_state;
  extern "duckdb_bind_null"
  proc duckdb_bind_null(prepared_statement: duckdb_prepared_statement,
                        bindIdx: idx_t): duckdb_state;
}

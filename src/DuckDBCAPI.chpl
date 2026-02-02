module DuckDBCAPI {
  use CTypes;

  require "duckdb.h";
  require "-lduckdb";

  // ============================================
  // Opaque Handle Types
  // ============================================

  extern "duckdb_database"   type duckdb_database;
  extern "duckdb_connection" type duckdb_connection;
  extern "duckdb_result"     type duckdb_result;
  extern "duckdb_prepared_statement" type duckdb_prepared_statement;

  // ============================================
  // Enum Types
  // ============================================

  extern "duckdb_state" type duckdb_state = c_int;
  extern const DuckDBSuccess: duckdb_state;
  extern const DuckDBError: duckdb_state;

  extern "duckdb_type" type duckdb_type = c_int;

  // ============================================
  // Other Types
  // ============================================

  extern "idx_t" type idx_t = uint(64);

  // ============================================
  // Database Lifecycle Functions
  // ============================================

  extern proc duckdb_open(path: c_ptrConst(c_char), 
                          ref database: duckdb_database): duckdb_state;
  extern proc duckdb_open_ext(path: c_ptrConst(c_char),
                              ref database: duckdb_database,
                              conf: c_ptr(void),
                              ref error: c_ptrConst(c_char)): duckdb_state;
  extern proc duckdb_close(ref database: duckdb_database): void;

  // ============================================
  // Connection Functions
  // ============================================

  extern proc duckdb_connect(database: duckdb_database,
                             ref connection: duckdb_connection): duckdb_state;
  extern proc duckdb_disconnect(ref connection: duckdb_connection): void;

  // ============================================
  // Query Execution Functions
  // ============================================

  extern proc duckdb_query(connection: duckdb_connection,
                           query: c_ptrConst(c_char),
                           ref result: duckdb_result): duckdb_state;
  extern proc duckdb_destroy_result(ref result: duckdb_result): void;

  // ============================================
  // Result Metadata Functions
  // ============================================

  extern proc duckdb_column_count(ref result: duckdb_result): idx_t;
  extern proc duckdb_row_count(ref result: duckdb_result): idx_t;
  extern proc duckdb_column_name(ref result: duckdb_result, 
                                  col: idx_t): c_ptrConst(c_char);
  extern proc duckdb_column_type(ref result: duckdb_result, 
                                  col: idx_t): duckdb_type;

  // ============================================
  // Value Extraction Functions
  // ============================================

  extern proc duckdb_value_varchar(ref result: duckdb_result,
                                    col: idx_t, row: idx_t): c_ptr(c_char);
  extern proc duckdb_value_int32(ref result: duckdb_result,
                                  col: idx_t, row: idx_t): int(32);
  extern proc duckdb_value_int64(ref result: duckdb_result,
                                  col: idx_t, row: idx_t): int(64);
  extern proc duckdb_value_double(ref result: duckdb_result,
                                   col: idx_t, row: idx_t): real(64);
  extern proc duckdb_value_boolean(ref result: duckdb_result,
                                    col: idx_t, row: idx_t): bool;
  extern proc duckdb_value_is_null(ref result: duckdb_result,
                                    col: idx_t, row: idx_t): bool;

  // ============================================
  // Error Handling Functions
  // ============================================

  extern proc duckdb_result_error(ref result: duckdb_result): c_ptrConst(c_char);

  // ============================================
  // Memory Management Functions
  // ============================================

  extern proc duckdb_free(ptr: c_ptr(void)): void;

  // ============================================
  // Prepared Statement Functions
  // ============================================

  extern proc duckdb_prepare(connection: duckdb_connection,
                              query: c_ptrConst(c_char),
                              ref out_prepared_statement: duckdb_prepared_statement): duckdb_state;
  extern proc duckdb_destroy_prepare(ref prepared_statement: duckdb_prepared_statement): void;
  extern proc duckdb_execute_prepared(prepared_statement: duckdb_prepared_statement,
                                       ref out_result: duckdb_result): duckdb_state;
  extern proc duckdb_bind_int64(prepared_statement: duckdb_prepared_statement,
                                 param_idx: idx_t, val: int(64)): duckdb_state;
  extern proc duckdb_bind_double(prepared_statement: duckdb_prepared_statement,
                                  param_idx: idx_t, val: real(64)): duckdb_state;
  extern proc duckdb_bind_varchar(prepared_statement: duckdb_prepared_statement,
                                   param_idx: idx_t, val: c_ptrConst(c_char)): duckdb_state;
  extern proc duckdb_bind_null(prepared_statement: duckdb_prepared_statement,
                                param_idx: idx_t): duckdb_state;
}

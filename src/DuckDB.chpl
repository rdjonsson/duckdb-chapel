module DuckDB
{

    // Generated with c2chapel version 0.1.0

    // Header given to c2chapel:
    require "duckdb.h";
    require "-lduckdb";
    // Note: Generated with fake std headers

    use CTypes;
    extern "struct duckdb_extension_access" record duckdb_extension_access {
    var set_error : c_fn_ptr;
    var get_database : c_fn_ptr;
    var get_api : c_fn_ptr;
    }

    extern proc duckdb_open(path : c_ptrConst(c_char), ref out_database : duckdb_database) : duckdb_state;

    extern proc duckdb_open(path : c_ptrConst(c_char), out_database : c_ptr(duckdb_database)) : duckdb_state;

    extern proc duckdb_open_ext(path : c_ptrConst(c_char), ref out_database : duckdb_database, config_arg : duckdb_config, ref out_error : c_ptr(c_char)) : duckdb_state;

    extern proc duckdb_open_ext(path : c_ptrConst(c_char), out_database : c_ptr(duckdb_database), config_arg : duckdb_config, out_error : c_ptr(c_ptr(c_char))) : duckdb_state;

    extern proc duckdb_close(ref database : duckdb_database) : void;

    extern proc duckdb_close(database : c_ptr(duckdb_database)) : void;

    extern proc duckdb_connect(database : duckdb_database, ref out_connection : duckdb_connection) : duckdb_state;

    extern proc duckdb_connect(database : duckdb_database, out_connection : c_ptr(duckdb_connection)) : duckdb_state;

    extern proc duckdb_interrupt(connection : duckdb_connection) : void;

    extern proc duckdb_query_progress(connection : duckdb_connection) : duckdb_query_progress_type;

    extern proc duckdb_disconnect(ref connection : duckdb_connection) : void;

    extern proc duckdb_disconnect(connection : c_ptr(duckdb_connection)) : void;

    extern proc duckdb_library_version() : c_ptrConst(c_char);

    extern proc duckdb_create_config(ref out_config : duckdb_config) : duckdb_state;

    extern proc duckdb_create_config(out_config : c_ptr(duckdb_config)) : duckdb_state;

    extern proc duckdb_config_count() : c_size_t;

    extern proc duckdb_get_config_flag(index_arg : c_size_t, ref out_name : c_ptrConst(c_char), ref out_description : c_ptrConst(c_char)) : duckdb_state;

    extern proc duckdb_get_config_flag(index_arg : c_size_t, out_name : c_ptr(c_ptrConst(c_char)), out_description : c_ptr(c_ptrConst(c_char))) : duckdb_state;

    extern proc duckdb_set_config(config_arg : duckdb_config, name : c_ptrConst(c_char), option : c_ptrConst(c_char)) : duckdb_state;

    extern proc duckdb_destroy_config(ref config_arg : duckdb_config) : void;

    extern proc duckdb_destroy_config(config_arg : c_ptr(duckdb_config)) : void;

    extern proc duckdb_query(connection : duckdb_connection, query : c_ptrConst(c_char), ref out_result : duckdb_result) : duckdb_state;

    extern proc duckdb_query(connection : duckdb_connection, query : c_ptrConst(c_char), out_result : c_ptr(duckdb_result)) : duckdb_state;

    extern proc duckdb_destroy_result(ref result : duckdb_result) : void;

    extern proc duckdb_destroy_result(result : c_ptr(duckdb_result)) : void;

    extern proc duckdb_column_name(ref result : duckdb_result, col : idx_t) : c_ptrConst(c_char);

    extern proc duckdb_column_name(result : c_ptr(duckdb_result), col : idx_t) : c_ptrConst(c_char);

    extern proc duckdb_column_type(ref result : duckdb_result, col : idx_t) : duckdb_type;

    extern proc duckdb_column_type(result : c_ptr(duckdb_result), col : idx_t) : duckdb_type;

    extern proc duckdb_result_statement_type(in result : duckdb_result) : duckdb_statement_type;

    extern proc duckdb_column_logical_type(ref result : duckdb_result, col : idx_t) : duckdb_logical_type;

    extern proc duckdb_column_logical_type(result : c_ptr(duckdb_result), col : idx_t) : duckdb_logical_type;

    extern proc duckdb_column_count(ref result : duckdb_result) : idx_t;

    extern proc duckdb_column_count(result : c_ptr(duckdb_result)) : idx_t;

    extern proc duckdb_row_count(ref result : duckdb_result) : idx_t;

    extern proc duckdb_row_count(result : c_ptr(duckdb_result)) : idx_t;

    extern proc duckdb_rows_changed(ref result : duckdb_result) : idx_t;

    extern proc duckdb_rows_changed(result : c_ptr(duckdb_result)) : idx_t;

    extern proc duckdb_column_data(ref result : duckdb_result, col : idx_t) : c_ptr(void);

    extern proc duckdb_column_data(result : c_ptr(duckdb_result), col : idx_t) : c_ptr(void);

    extern proc duckdb_nullmask_data(ref result : duckdb_result, col : idx_t) : c_ptr(bool);

    extern proc duckdb_nullmask_data(result : c_ptr(duckdb_result), col : idx_t) : c_ptr(bool);

    extern proc duckdb_result_error(ref result : duckdb_result) : c_ptrConst(c_char);

    extern proc duckdb_result_error(result : c_ptr(duckdb_result)) : c_ptrConst(c_char);

    extern proc duckdb_result_error_type(ref result : duckdb_result) : duckdb_error_type;

    extern proc duckdb_result_error_type(result : c_ptr(duckdb_result)) : duckdb_error_type;

    extern proc duckdb_result_get_chunk(in result : duckdb_result, chunk_index : idx_t) : duckdb_data_chunk;

    extern proc duckdb_result_is_streaming(in result : duckdb_result) : bool;

    extern proc duckdb_result_chunk_count(in result : duckdb_result) : idx_t;

    extern proc duckdb_result_return_type(in result : duckdb_result) : duckdb_result_type;

    extern proc duckdb_value_boolean(ref result : duckdb_result, col : idx_t, row : idx_t) : bool;

    extern proc duckdb_value_boolean(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : bool;

    extern proc duckdb_value_int8(ref result : duckdb_result, col : idx_t, row : idx_t) : int(8);

    extern proc duckdb_value_int8(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : int(8);

    extern proc duckdb_value_int16(ref result : duckdb_result, col : idx_t, row : idx_t) : int(16);

    extern proc duckdb_value_int16(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : int(16);

    extern proc duckdb_value_int32(ref result : duckdb_result, col : idx_t, row : idx_t) : int(32);

    extern proc duckdb_value_int32(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : int(32);

    extern proc duckdb_value_int64(ref result : duckdb_result, col : idx_t, row : idx_t) : int(64);

    extern proc duckdb_value_int64(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : int(64);

    extern proc duckdb_value_hugeint(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_hugeint;

    extern proc duckdb_value_hugeint(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_hugeint;

    extern proc duckdb_value_uhugeint(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_uhugeint;

    extern proc duckdb_value_uhugeint(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_uhugeint;

    extern proc duckdb_value_decimal(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_decimal;

    extern proc duckdb_value_decimal(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_decimal;

    extern proc duckdb_value_uint8(ref result : duckdb_result, col : idx_t, row : idx_t) : uint(8);

    extern proc duckdb_value_uint8(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : uint(8);

    extern proc duckdb_value_uint16(ref result : duckdb_result, col : idx_t, row : idx_t) : uint(16);

    extern proc duckdb_value_uint16(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : uint(16);

    extern proc duckdb_value_uint32(ref result : duckdb_result, col : idx_t, row : idx_t) : uint(32);

    extern proc duckdb_value_uint32(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : uint(32);

    extern proc duckdb_value_uint64(ref result : duckdb_result, col : idx_t, row : idx_t) : uint(64);

    extern proc duckdb_value_uint64(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : uint(64);

    extern proc duckdb_value_float(ref result : duckdb_result, col : idx_t, row : idx_t) : c_float;

    extern proc duckdb_value_float(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : c_float;

    extern proc duckdb_value_double(ref result : duckdb_result, col : idx_t, row : idx_t) : c_double;

    extern proc duckdb_value_double(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : c_double;

    extern proc duckdb_value_date(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_date;

    extern proc duckdb_value_date(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_date;

    extern proc duckdb_value_time(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_time;

    extern proc duckdb_value_time(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_time;

    extern proc duckdb_value_timestamp(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_timestamp;

    extern proc duckdb_value_timestamp(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_timestamp;

    extern proc duckdb_value_interval(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_interval;

    extern proc duckdb_value_interval(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_interval;

    extern proc duckdb_value_varchar(ref result : duckdb_result, col : idx_t, row : idx_t) : c_ptr(c_char);

    extern proc duckdb_value_varchar(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : c_ptr(c_char);

    extern proc duckdb_value_string(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_string;

    extern proc duckdb_value_string(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_string;

    extern proc duckdb_value_varchar_internal(ref result : duckdb_result, col : idx_t, row : idx_t) : c_ptr(c_char);

    extern proc duckdb_value_varchar_internal(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : c_ptr(c_char);

    extern proc duckdb_value_string_internal(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_string;

    extern proc duckdb_value_string_internal(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_string;

    extern proc duckdb_value_blob(ref result : duckdb_result, col : idx_t, row : idx_t) : duckdb_blob;

    extern proc duckdb_value_blob(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : duckdb_blob;

    extern proc duckdb_value_is_null(ref result : duckdb_result, col : idx_t, row : idx_t) : bool;

    extern proc duckdb_value_is_null(result : c_ptr(duckdb_result), col : idx_t, row : idx_t) : bool;

    extern proc duckdb_malloc(size : c_size_t) : c_ptr(void);

    extern proc duckdb_free(ptr : c_ptr(void)) : void;

    extern proc duckdb_vector_size() : idx_t;

    extern proc duckdb_string_is_inlined(in string_arg : duckdb_string_t) : bool;

    extern proc duckdb_string_t_length(in string_arg : duckdb_string_t) : uint(32);

    extern proc duckdb_string_t_data(ref string_arg : duckdb_string_t) : c_ptrConst(c_char);

    extern proc duckdb_string_t_data(string_arg : c_ptr(duckdb_string_t)) : c_ptrConst(c_char);

    extern proc duckdb_from_date(in date : duckdb_date) : duckdb_date_struct;

    extern proc duckdb_to_date(in date : duckdb_date_struct) : duckdb_date;

    extern proc duckdb_is_finite_date(in date : duckdb_date) : bool;

    extern proc duckdb_from_time(in time : duckdb_time) : duckdb_time_struct;

    extern proc duckdb_create_time_tz(micros : int(64), offset : int(32)) : duckdb_time_tz;

    extern proc duckdb_from_time_tz(in micros : duckdb_time_tz) : duckdb_time_tz_struct;

    extern proc duckdb_to_time(in time : duckdb_time_struct) : duckdb_time;

    extern proc duckdb_from_timestamp(in ts : duckdb_timestamp) : duckdb_timestamp_struct;

    extern proc duckdb_to_timestamp(in ts : duckdb_timestamp_struct) : duckdb_timestamp;

    extern proc duckdb_is_finite_timestamp(in ts : duckdb_timestamp) : bool;

    extern proc duckdb_hugeint_to_double(in val : duckdb_hugeint) : c_double;

    extern proc duckdb_double_to_hugeint(val : c_double) : duckdb_hugeint;

    extern proc duckdb_uhugeint_to_double(in val : duckdb_uhugeint) : c_double;

    extern proc duckdb_double_to_uhugeint(val : c_double) : duckdb_uhugeint;

    extern proc duckdb_double_to_decimal(val : c_double, width : uint(8), scale : uint(8)) : duckdb_decimal;

    extern proc duckdb_decimal_to_double(in val : duckdb_decimal) : c_double;

    extern proc duckdb_prepare(connection : duckdb_connection, query : c_ptrConst(c_char), ref out_prepared_statement : duckdb_prepared_statement) : duckdb_state;

    extern proc duckdb_prepare(connection : duckdb_connection, query : c_ptrConst(c_char), out_prepared_statement : c_ptr(duckdb_prepared_statement)) : duckdb_state;

    extern proc duckdb_destroy_prepare(ref prepared_statement : duckdb_prepared_statement) : void;

    extern proc duckdb_destroy_prepare(prepared_statement : c_ptr(duckdb_prepared_statement)) : void;

    extern proc duckdb_prepare_error(prepared_statement : duckdb_prepared_statement) : c_ptrConst(c_char);

    extern proc duckdb_nparams(prepared_statement : duckdb_prepared_statement) : idx_t;

    extern proc duckdb_parameter_name(prepared_statement : duckdb_prepared_statement, index_arg : idx_t) : c_ptrConst(c_char);

    extern proc duckdb_param_type(prepared_statement : duckdb_prepared_statement, param_idx : idx_t) : duckdb_type;

    extern proc duckdb_clear_bindings(prepared_statement : duckdb_prepared_statement) : duckdb_state;

    extern proc duckdb_prepared_statement_type(statement : duckdb_prepared_statement) : duckdb_statement_type;

    extern proc duckdb_bind_value(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : duckdb_value) : duckdb_state;

    extern proc duckdb_bind_parameter_index(prepared_statement : duckdb_prepared_statement, ref param_idx_out : idx_t, name : c_ptrConst(c_char)) : duckdb_state;

    extern proc duckdb_bind_parameter_index(prepared_statement : duckdb_prepared_statement, param_idx_out : c_ptr(idx_t), name : c_ptrConst(c_char)) : duckdb_state;

    extern proc duckdb_bind_boolean(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : bool) : duckdb_state;

    extern proc duckdb_bind_int8(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : int(8)) : duckdb_state;

    extern proc duckdb_bind_int16(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : int(16)) : duckdb_state;

    extern proc duckdb_bind_int32(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : int(32)) : duckdb_state;

    extern proc duckdb_bind_int64(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : int(64)) : duckdb_state;

    extern proc duckdb_bind_hugeint(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_hugeint) : duckdb_state;

    extern proc duckdb_bind_uhugeint(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_uhugeint) : duckdb_state;

    extern proc duckdb_bind_decimal(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_decimal) : duckdb_state;

    extern proc duckdb_bind_uint8(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : uint(8)) : duckdb_state;

    extern proc duckdb_bind_uint16(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : uint(16)) : duckdb_state;

    extern proc duckdb_bind_uint32(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : uint(32)) : duckdb_state;

    extern proc duckdb_bind_uint64(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : uint(64)) : duckdb_state;

    extern proc duckdb_bind_float(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : c_float) : duckdb_state;

    extern proc duckdb_bind_double(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : c_double) : duckdb_state;

    extern proc duckdb_bind_date(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_date) : duckdb_state;

    extern proc duckdb_bind_time(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_time) : duckdb_state;

    extern proc duckdb_bind_timestamp(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_timestamp) : duckdb_state;

    extern proc duckdb_bind_timestamp_tz(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_timestamp) : duckdb_state;

    extern proc duckdb_bind_interval(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, in val : duckdb_interval) : duckdb_state;

    extern proc duckdb_bind_varchar(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : c_ptrConst(c_char)) : duckdb_state;

    extern proc duckdb_bind_varchar_length(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, val : c_ptrConst(c_char), length : idx_t) : duckdb_state;

    extern proc duckdb_bind_blob(prepared_statement : duckdb_prepared_statement, param_idx : idx_t, data : c_ptrConst(void), length : idx_t) : duckdb_state;

    extern proc duckdb_bind_null(prepared_statement : duckdb_prepared_statement, param_idx : idx_t) : duckdb_state;

    extern proc duckdb_execute_prepared(prepared_statement : duckdb_prepared_statement, ref out_result : duckdb_result) : duckdb_state;

    extern proc duckdb_execute_prepared(prepared_statement : duckdb_prepared_statement, out_result : c_ptr(duckdb_result)) : duckdb_state;

    extern proc duckdb_execute_prepared_streaming(prepared_statement : duckdb_prepared_statement, ref out_result : duckdb_result) : duckdb_state;

    extern proc duckdb_execute_prepared_streaming(prepared_statement : duckdb_prepared_statement, out_result : c_ptr(duckdb_result)) : duckdb_state;

    extern proc duckdb_extract_statements(connection : duckdb_connection, query : c_ptrConst(c_char), ref out_extracted_statements : duckdb_extracted_statements) : idx_t;

    extern proc duckdb_extract_statements(connection : duckdb_connection, query : c_ptrConst(c_char), out_extracted_statements : c_ptr(duckdb_extracted_statements)) : idx_t;

    extern proc duckdb_prepare_extracted_statement(connection : duckdb_connection, extracted_statements : duckdb_extracted_statements, index_arg : idx_t, ref out_prepared_statement : duckdb_prepared_statement) : duckdb_state;

    extern proc duckdb_prepare_extracted_statement(connection : duckdb_connection, extracted_statements : duckdb_extracted_statements, index_arg : idx_t, out_prepared_statement : c_ptr(duckdb_prepared_statement)) : duckdb_state;

    extern proc duckdb_extract_statements_error(extracted_statements : duckdb_extracted_statements) : c_ptrConst(c_char);

    extern proc duckdb_destroy_extracted(ref extracted_statements : duckdb_extracted_statements) : void;

    extern proc duckdb_destroy_extracted(extracted_statements : c_ptr(duckdb_extracted_statements)) : void;

    extern proc duckdb_pending_prepared(prepared_statement : duckdb_prepared_statement, ref out_result : duckdb_pending_result) : duckdb_state;

    extern proc duckdb_pending_prepared(prepared_statement : duckdb_prepared_statement, out_result : c_ptr(duckdb_pending_result)) : duckdb_state;

    extern proc duckdb_pending_prepared_streaming(prepared_statement : duckdb_prepared_statement, ref out_result : duckdb_pending_result) : duckdb_state;

    extern proc duckdb_pending_prepared_streaming(prepared_statement : duckdb_prepared_statement, out_result : c_ptr(duckdb_pending_result)) : duckdb_state;

    extern proc duckdb_destroy_pending(ref pending_result : duckdb_pending_result) : void;

    extern proc duckdb_destroy_pending(pending_result : c_ptr(duckdb_pending_result)) : void;

    extern proc duckdb_pending_error(pending_result : duckdb_pending_result) : c_ptrConst(c_char);

    extern proc duckdb_pending_execute_task(pending_result : duckdb_pending_result) : duckdb_pending_state;

    extern proc duckdb_pending_execute_check_state(pending_result : duckdb_pending_result) : duckdb_pending_state;

    extern proc duckdb_execute_pending(pending_result : duckdb_pending_result, ref out_result : duckdb_result) : duckdb_state;

    extern proc duckdb_execute_pending(pending_result : duckdb_pending_result, out_result : c_ptr(duckdb_result)) : duckdb_state;

    extern proc duckdb_pending_execution_is_finished(pending_state : duckdb_pending_state) : bool;

    extern proc duckdb_destroy_value(ref value : duckdb_value) : void;

    extern proc duckdb_destroy_value(value : c_ptr(duckdb_value)) : void;

    extern proc duckdb_create_varchar(text : c_ptrConst(c_char)) : duckdb_value;

    extern proc duckdb_create_varchar_length(text : c_ptrConst(c_char), length : idx_t) : duckdb_value;

    extern proc duckdb_create_bool(input : bool) : duckdb_value;

    extern proc duckdb_create_int8(input : int(8)) : duckdb_value;

    extern proc duckdb_create_uint8(input : uint(8)) : duckdb_value;

    extern proc duckdb_create_int16(input : int(16)) : duckdb_value;

    extern proc duckdb_create_uint16(input : uint(16)) : duckdb_value;

    extern proc duckdb_create_int32(input : int(32)) : duckdb_value;

    extern proc duckdb_create_uint32(input : uint(32)) : duckdb_value;

    extern proc duckdb_create_uint64(input : uint(64)) : duckdb_value;

    extern proc duckdb_create_int64(val : int(64)) : duckdb_value;

    extern proc duckdb_create_hugeint(in input : duckdb_hugeint) : duckdb_value;

    extern proc duckdb_create_uhugeint(in input : duckdb_uhugeint) : duckdb_value;

    extern proc duckdb_create_float(input : c_float) : duckdb_value;

    extern proc duckdb_create_double(input : c_double) : duckdb_value;

    extern proc duckdb_create_date(in input : duckdb_date) : duckdb_value;

    extern proc duckdb_create_time(in input : duckdb_time) : duckdb_value;

    extern proc duckdb_create_time_tz_value(in value : duckdb_time_tz) : duckdb_value;

    extern proc duckdb_create_timestamp(in input : duckdb_timestamp) : duckdb_value;

    extern proc duckdb_create_interval(in input : duckdb_interval) : duckdb_value;

    extern proc duckdb_create_blob(const ref data : uint(8), length : idx_t) : duckdb_value;

    extern proc duckdb_create_blob(data : c_ptrConst(uint(8)), length : idx_t) : duckdb_value;

    extern proc duckdb_get_bool(val : duckdb_value) : bool;

    extern proc duckdb_get_int8(val : duckdb_value) : int(8);

    extern proc duckdb_get_uint8(val : duckdb_value) : uint(8);

    extern proc duckdb_get_int16(val : duckdb_value) : int(16);

    extern proc duckdb_get_uint16(val : duckdb_value) : uint(16);

    extern proc duckdb_get_int32(val : duckdb_value) : int(32);

    extern proc duckdb_get_uint32(val : duckdb_value) : uint(32);

    extern proc duckdb_get_int64(val : duckdb_value) : int(64);

    extern proc duckdb_get_uint64(val : duckdb_value) : uint(64);

    extern proc duckdb_get_hugeint(val : duckdb_value) : duckdb_hugeint;

    extern proc duckdb_get_uhugeint(val : duckdb_value) : duckdb_uhugeint;

    extern proc duckdb_get_float(val : duckdb_value) : c_float;

    extern proc duckdb_get_double(val : duckdb_value) : c_double;

    extern proc duckdb_get_date(val : duckdb_value) : duckdb_date;

    extern proc duckdb_get_time(val : duckdb_value) : duckdb_time;

    extern proc duckdb_get_time_tz(val : duckdb_value) : duckdb_time_tz;

    extern proc duckdb_get_timestamp(val : duckdb_value) : duckdb_timestamp;

    extern proc duckdb_get_interval(val : duckdb_value) : duckdb_interval;

    extern proc duckdb_get_value_type(val : duckdb_value) : duckdb_logical_type;

    extern proc duckdb_get_blob(val : duckdb_value) : duckdb_blob;

    extern proc duckdb_get_varchar(value : duckdb_value) : c_ptr(c_char);

    extern proc duckdb_create_struct_value(type_arg : duckdb_logical_type, ref values : duckdb_value) : duckdb_value;

    extern proc duckdb_create_struct_value(type_arg : duckdb_logical_type, values : c_ptr(duckdb_value)) : duckdb_value;

    extern proc duckdb_create_list_value(type_arg : duckdb_logical_type, ref values : duckdb_value, value_count : idx_t) : duckdb_value;

    extern proc duckdb_create_list_value(type_arg : duckdb_logical_type, values : c_ptr(duckdb_value), value_count : idx_t) : duckdb_value;

    extern proc duckdb_create_array_value(type_arg : duckdb_logical_type, ref values : duckdb_value, value_count : idx_t) : duckdb_value;

    extern proc duckdb_create_array_value(type_arg : duckdb_logical_type, values : c_ptr(duckdb_value), value_count : idx_t) : duckdb_value;

    extern proc duckdb_get_map_size(value : duckdb_value) : idx_t;

    extern proc duckdb_get_map_key(value : duckdb_value, index_arg : idx_t) : duckdb_value;

    extern proc duckdb_get_map_value(value : duckdb_value, index_arg : idx_t) : duckdb_value;

    extern proc duckdb_create_logical_type(type_arg : duckdb_type) : duckdb_logical_type;

    extern proc duckdb_logical_type_get_alias(type_arg : duckdb_logical_type) : c_ptr(c_char);

    extern proc duckdb_logical_type_set_alias(type_arg : duckdb_logical_type, alias : c_ptrConst(c_char)) : void;

    extern proc duckdb_create_list_type(type_arg : duckdb_logical_type) : duckdb_logical_type;

    extern proc duckdb_create_array_type(type_arg : duckdb_logical_type, array_size : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_map_type(key_type : duckdb_logical_type, value_type : duckdb_logical_type) : duckdb_logical_type;

    extern proc duckdb_create_union_type(ref member_types : duckdb_logical_type, ref member_names : c_ptrConst(c_char), member_count : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_union_type(member_types : c_ptr(duckdb_logical_type), member_names : c_ptr(c_ptrConst(c_char)), member_count : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_struct_type(ref member_types : duckdb_logical_type, ref member_names : c_ptrConst(c_char), member_count : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_struct_type(member_types : c_ptr(duckdb_logical_type), member_names : c_ptr(c_ptrConst(c_char)), member_count : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_enum_type(ref member_names : c_ptrConst(c_char), member_count : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_enum_type(member_names : c_ptr(c_ptrConst(c_char)), member_count : idx_t) : duckdb_logical_type;

    extern proc duckdb_create_decimal_type(width : uint(8), scale : uint(8)) : duckdb_logical_type;

    extern proc duckdb_get_type_id(type_arg : duckdb_logical_type) : duckdb_type;

    extern proc duckdb_decimal_width(type_arg : duckdb_logical_type) : uint(8);

    extern proc duckdb_decimal_scale(type_arg : duckdb_logical_type) : uint(8);

    extern proc duckdb_decimal_internal_type(type_arg : duckdb_logical_type) : duckdb_type;

    extern proc duckdb_enum_internal_type(type_arg : duckdb_logical_type) : duckdb_type;

    extern proc duckdb_enum_dictionary_size(type_arg : duckdb_logical_type) : uint(32);

    extern proc duckdb_enum_dictionary_value(type_arg : duckdb_logical_type, index_arg : idx_t) : c_ptr(c_char);

    extern proc duckdb_list_type_child_type(type_arg : duckdb_logical_type) : duckdb_logical_type;

    extern proc duckdb_array_type_child_type(type_arg : duckdb_logical_type) : duckdb_logical_type;

    extern proc duckdb_array_type_array_size(type_arg : duckdb_logical_type) : idx_t;

    extern proc duckdb_map_type_key_type(type_arg : duckdb_logical_type) : duckdb_logical_type;

    extern proc duckdb_map_type_value_type(type_arg : duckdb_logical_type) : duckdb_logical_type;

    extern proc duckdb_struct_type_child_count(type_arg : duckdb_logical_type) : idx_t;

    extern proc duckdb_struct_type_child_name(type_arg : duckdb_logical_type, index_arg : idx_t) : c_ptr(c_char);

    extern proc duckdb_struct_type_child_type(type_arg : duckdb_logical_type, index_arg : idx_t) : duckdb_logical_type;

    extern proc duckdb_union_type_member_count(type_arg : duckdb_logical_type) : idx_t;

    extern proc duckdb_union_type_member_name(type_arg : duckdb_logical_type, index_arg : idx_t) : c_ptr(c_char);

    extern proc duckdb_union_type_member_type(type_arg : duckdb_logical_type, index_arg : idx_t) : duckdb_logical_type;

    extern proc duckdb_destroy_logical_type(ref type_arg : duckdb_logical_type) : void;

    extern proc duckdb_destroy_logical_type(type_arg : c_ptr(duckdb_logical_type)) : void;

    extern proc duckdb_register_logical_type(con : duckdb_connection, type_arg : duckdb_logical_type, info : duckdb_create_type_info) : duckdb_state;

    extern proc duckdb_create_data_chunk(ref types : duckdb_logical_type, column_count : idx_t) : duckdb_data_chunk;

    extern proc duckdb_create_data_chunk(types : c_ptr(duckdb_logical_type), column_count : idx_t) : duckdb_data_chunk;

    extern proc duckdb_destroy_data_chunk(ref chunk : duckdb_data_chunk) : void;

    extern proc duckdb_destroy_data_chunk(chunk : c_ptr(duckdb_data_chunk)) : void;

    extern proc duckdb_data_chunk_reset(chunk : duckdb_data_chunk) : void;

    extern proc duckdb_data_chunk_get_column_count(chunk : duckdb_data_chunk) : idx_t;

    extern proc duckdb_data_chunk_get_vector(chunk : duckdb_data_chunk, col_idx : idx_t) : duckdb_vector;

    extern proc duckdb_data_chunk_get_size(chunk : duckdb_data_chunk) : idx_t;

    extern proc duckdb_data_chunk_set_size(chunk : duckdb_data_chunk, size : idx_t) : void;

    extern proc duckdb_vector_get_column_type(vector : duckdb_vector) : duckdb_logical_type;

    extern proc duckdb_vector_get_data(vector : duckdb_vector) : c_ptr(void);

    extern proc duckdb_vector_get_validity(vector : duckdb_vector) : c_ptr(uint(64));

    extern proc duckdb_vector_ensure_validity_writable(vector : duckdb_vector) : void;

    extern proc duckdb_vector_assign_string_element(vector : duckdb_vector, index_arg : idx_t, str : c_ptrConst(c_char)) : void;

    extern proc duckdb_vector_assign_string_element_len(vector : duckdb_vector, index_arg : idx_t, str : c_ptrConst(c_char), str_len : idx_t) : void;

    extern proc duckdb_list_vector_get_child(vector : duckdb_vector) : duckdb_vector;

    extern proc duckdb_list_vector_get_size(vector : duckdb_vector) : idx_t;

    extern proc duckdb_list_vector_set_size(vector : duckdb_vector, size : idx_t) : duckdb_state;

    extern proc duckdb_list_vector_reserve(vector : duckdb_vector, required_capacity : idx_t) : duckdb_state;

    extern proc duckdb_struct_vector_get_child(vector : duckdb_vector, index_arg : idx_t) : duckdb_vector;

    extern proc duckdb_array_vector_get_child(vector : duckdb_vector) : duckdb_vector;

    extern proc duckdb_validity_row_is_valid(ref validity : uint(64), row : idx_t) : bool;

    extern proc duckdb_validity_row_is_valid(validity : c_ptr(uint(64)), row : idx_t) : bool;

    extern proc duckdb_validity_set_row_validity(ref validity : uint(64), row : idx_t, valid : bool) : void;

    extern proc duckdb_validity_set_row_validity(validity : c_ptr(uint(64)), row : idx_t, valid : bool) : void;

    extern proc duckdb_validity_set_row_invalid(ref validity : uint(64), row : idx_t) : void;

    extern proc duckdb_validity_set_row_invalid(validity : c_ptr(uint(64)), row : idx_t) : void;

    extern proc duckdb_validity_set_row_valid(ref validity : uint(64), row : idx_t) : void;

    extern proc duckdb_validity_set_row_valid(validity : c_ptr(uint(64)), row : idx_t) : void;

    extern proc duckdb_create_scalar_function() : duckdb_scalar_function;

    extern proc duckdb_destroy_scalar_function(ref scalar_function : duckdb_scalar_function) : void;

    extern proc duckdb_destroy_scalar_function(scalar_function : c_ptr(duckdb_scalar_function)) : void;

    extern proc duckdb_scalar_function_set_name(scalar_function : duckdb_scalar_function, name : c_ptrConst(c_char)) : void;

    extern proc duckdb_scalar_function_set_varargs(scalar_function : duckdb_scalar_function, type_arg : duckdb_logical_type) : void;

    extern proc duckdb_scalar_function_set_special_handling(scalar_function : duckdb_scalar_function) : void;

    extern proc duckdb_scalar_function_set_volatile(scalar_function : duckdb_scalar_function) : void;

    extern proc duckdb_scalar_function_add_parameter(scalar_function : duckdb_scalar_function, type_arg : duckdb_logical_type) : void;

    extern proc duckdb_scalar_function_set_return_type(scalar_function : duckdb_scalar_function, type_arg : duckdb_logical_type) : void;

    extern proc duckdb_scalar_function_set_extra_info(scalar_function : duckdb_scalar_function, extra_info : c_ptr(void), destroy : duckdb_delete_callback_t) : void;

    extern proc duckdb_scalar_function_set_function(scalar_function : duckdb_scalar_function, function : duckdb_scalar_function_t) : void;

    extern proc duckdb_register_scalar_function(con : duckdb_connection, scalar_function : duckdb_scalar_function) : duckdb_state;

    extern proc duckdb_scalar_function_get_extra_info(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_scalar_function_set_error(info : duckdb_function_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_create_scalar_function_set(name : c_ptrConst(c_char)) : duckdb_scalar_function_set;

    extern proc duckdb_destroy_scalar_function_set(ref scalar_function_set : duckdb_scalar_function_set) : void;

    extern proc duckdb_destroy_scalar_function_set(scalar_function_set : c_ptr(duckdb_scalar_function_set)) : void;

    extern proc duckdb_add_scalar_function_to_set(set : duckdb_scalar_function_set, function : duckdb_scalar_function) : duckdb_state;

    extern proc duckdb_register_scalar_function_set(con : duckdb_connection, set : duckdb_scalar_function_set) : duckdb_state;

    extern proc duckdb_create_aggregate_function() : duckdb_aggregate_function;

    extern proc duckdb_destroy_aggregate_function(ref aggregate_function : duckdb_aggregate_function) : void;

    extern proc duckdb_destroy_aggregate_function(aggregate_function : c_ptr(duckdb_aggregate_function)) : void;

    extern proc duckdb_aggregate_function_set_name(aggregate_function : duckdb_aggregate_function, name : c_ptrConst(c_char)) : void;

    extern proc duckdb_aggregate_function_add_parameter(aggregate_function : duckdb_aggregate_function, type_arg : duckdb_logical_type) : void;

    extern proc duckdb_aggregate_function_set_return_type(aggregate_function : duckdb_aggregate_function, type_arg : duckdb_logical_type) : void;

    extern proc duckdb_aggregate_function_set_functions(aggregate_function : duckdb_aggregate_function, state_size : duckdb_aggregate_state_size, state_init : duckdb_aggregate_init_t, update : duckdb_aggregate_update_t, combine : duckdb_aggregate_combine_t, finalize : duckdb_aggregate_finalize_t) : void;

    extern proc duckdb_aggregate_function_set_destructor(aggregate_function : duckdb_aggregate_function, destroy : duckdb_aggregate_destroy_t) : void;

    extern proc duckdb_register_aggregate_function(con : duckdb_connection, aggregate_function : duckdb_aggregate_function) : duckdb_state;

    extern proc duckdb_aggregate_function_set_special_handling(aggregate_function : duckdb_aggregate_function) : void;

    extern proc duckdb_aggregate_function_set_extra_info(aggregate_function : duckdb_aggregate_function, extra_info : c_ptr(void), destroy : duckdb_delete_callback_t) : void;

    extern proc duckdb_aggregate_function_get_extra_info(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_aggregate_function_set_error(info : duckdb_function_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_create_aggregate_function_set(name : c_ptrConst(c_char)) : duckdb_aggregate_function_set;

    extern proc duckdb_destroy_aggregate_function_set(ref aggregate_function_set : duckdb_aggregate_function_set) : void;

    extern proc duckdb_destroy_aggregate_function_set(aggregate_function_set : c_ptr(duckdb_aggregate_function_set)) : void;

    extern proc duckdb_add_aggregate_function_to_set(set : duckdb_aggregate_function_set, function : duckdb_aggregate_function) : duckdb_state;

    extern proc duckdb_register_aggregate_function_set(con : duckdb_connection, set : duckdb_aggregate_function_set) : duckdb_state;

    extern proc duckdb_create_table_function() : duckdb_table_function;

    extern proc duckdb_destroy_table_function(ref table_function : duckdb_table_function) : void;

    extern proc duckdb_destroy_table_function(table_function : c_ptr(duckdb_table_function)) : void;

    extern proc duckdb_table_function_set_name(table_function : duckdb_table_function, name : c_ptrConst(c_char)) : void;

    extern proc duckdb_table_function_add_parameter(table_function : duckdb_table_function, type_arg : duckdb_logical_type) : void;

    extern proc duckdb_table_function_add_named_parameter(table_function : duckdb_table_function, name : c_ptrConst(c_char), type_arg : duckdb_logical_type) : void;

    extern proc duckdb_table_function_set_extra_info(table_function : duckdb_table_function, extra_info : c_ptr(void), destroy : duckdb_delete_callback_t) : void;

    extern proc duckdb_table_function_set_bind(table_function : duckdb_table_function, bind : duckdb_table_function_bind_t) : void;

    extern proc duckdb_table_function_set_init(table_function : duckdb_table_function, init_t : duckdb_table_function_init_t) : void;

    extern proc duckdb_table_function_set_local_init(table_function : duckdb_table_function, init_t : duckdb_table_function_init_t) : void;

    extern proc duckdb_table_function_set_function(table_function : duckdb_table_function, function : duckdb_table_function_t) : void;

    extern proc duckdb_table_function_supports_projection_pushdown(table_function : duckdb_table_function, pushdown : bool) : void;

    extern proc duckdb_register_table_function(con : duckdb_connection, function : duckdb_table_function) : duckdb_state;

    extern proc duckdb_bind_get_extra_info(info : duckdb_bind_info) : c_ptr(void);

    extern proc duckdb_bind_add_result_column(info : duckdb_bind_info, name : c_ptrConst(c_char), type_arg : duckdb_logical_type) : void;

    extern proc duckdb_bind_get_parameter_count(info : duckdb_bind_info) : idx_t;

    extern proc duckdb_bind_get_parameter(info : duckdb_bind_info, index_arg : idx_t) : duckdb_value;

    extern proc duckdb_bind_get_named_parameter(info : duckdb_bind_info, name : c_ptrConst(c_char)) : duckdb_value;

    extern proc duckdb_bind_set_bind_data(info : duckdb_bind_info, bind_data : c_ptr(void), destroy : duckdb_delete_callback_t) : void;

    extern proc duckdb_bind_set_cardinality(info : duckdb_bind_info, cardinality : idx_t, is_exact : bool) : void;

    extern proc duckdb_bind_set_error(info : duckdb_bind_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_init_get_extra_info(info : duckdb_init_info) : c_ptr(void);

    extern proc duckdb_init_get_bind_data(info : duckdb_init_info) : c_ptr(void);

    extern proc duckdb_init_set_init_data(info : duckdb_init_info, init_data : c_ptr(void), destroy : duckdb_delete_callback_t) : void;

    extern proc duckdb_init_get_column_count(info : duckdb_init_info) : idx_t;

    extern proc duckdb_init_get_column_index(info : duckdb_init_info, column_index : idx_t) : idx_t;

    extern proc duckdb_init_set_max_threads(info : duckdb_init_info, max_threads : idx_t) : void;

    extern proc duckdb_init_set_error(info : duckdb_init_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_function_get_extra_info(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_function_get_bind_data(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_function_get_init_data(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_function_get_local_init_data(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_function_set_error(info : duckdb_function_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_add_replacement_scan(db : duckdb_database, replacement : duckdb_replacement_callback_t, extra_data : c_ptr(void), delete_callback : duckdb_delete_callback_t) : void;

    extern proc duckdb_replacement_scan_set_function_name(info : duckdb_replacement_scan_info, function_name : c_ptrConst(c_char)) : void;

    extern proc duckdb_replacement_scan_add_parameter(info : duckdb_replacement_scan_info, parameter : duckdb_value) : void;

    extern proc duckdb_replacement_scan_set_error(info : duckdb_replacement_scan_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_get_profiling_info(connection : duckdb_connection) : duckdb_profiling_info;

    extern proc duckdb_profiling_info_get_value(info : duckdb_profiling_info, key : c_ptrConst(c_char)) : duckdb_value;

    extern proc duckdb_profiling_info_get_metrics(info : duckdb_profiling_info) : duckdb_value;

    extern proc duckdb_profiling_info_get_child_count(info : duckdb_profiling_info) : idx_t;

    extern proc duckdb_profiling_info_get_child(info : duckdb_profiling_info, index_arg : idx_t) : duckdb_profiling_info;

    extern proc duckdb_appender_create(connection : duckdb_connection, schema : c_ptrConst(c_char), table : c_ptrConst(c_char), ref out_appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_appender_create(connection : duckdb_connection, schema : c_ptrConst(c_char), table : c_ptrConst(c_char), out_appender : c_ptr(duckdb_appender)) : duckdb_state;

    extern proc duckdb_appender_column_count(appender : duckdb_appender) : idx_t;

    extern proc duckdb_appender_column_type(appender : duckdb_appender, col_idx : idx_t) : duckdb_logical_type;

    extern proc duckdb_appender_error(appender : duckdb_appender) : c_ptrConst(c_char);

    extern proc duckdb_appender_flush(appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_appender_close(appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_appender_destroy(ref appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_appender_destroy(appender : c_ptr(duckdb_appender)) : duckdb_state;

    extern proc duckdb_appender_begin_row(appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_appender_end_row(appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_append_default(appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_append_bool(appender : duckdb_appender, value : bool) : duckdb_state;

    extern proc duckdb_append_int8(appender : duckdb_appender, value : int(8)) : duckdb_state;

    extern proc duckdb_append_int16(appender : duckdb_appender, value : int(16)) : duckdb_state;

    extern proc duckdb_append_int32(appender : duckdb_appender, value : int(32)) : duckdb_state;

    extern proc duckdb_append_int64(appender : duckdb_appender, value : int(64)) : duckdb_state;

    extern proc duckdb_append_hugeint(appender : duckdb_appender, in value : duckdb_hugeint) : duckdb_state;

    extern proc duckdb_append_uint8(appender : duckdb_appender, value : uint(8)) : duckdb_state;

    extern proc duckdb_append_uint16(appender : duckdb_appender, value : uint(16)) : duckdb_state;

    extern proc duckdb_append_uint32(appender : duckdb_appender, value : uint(32)) : duckdb_state;

    extern proc duckdb_append_uint64(appender : duckdb_appender, value : uint(64)) : duckdb_state;

    extern proc duckdb_append_uhugeint(appender : duckdb_appender, in value : duckdb_uhugeint) : duckdb_state;

    extern proc duckdb_append_float(appender : duckdb_appender, value : c_float) : duckdb_state;

    extern proc duckdb_append_double(appender : duckdb_appender, value : c_double) : duckdb_state;

    extern proc duckdb_append_date(appender : duckdb_appender, in value : duckdb_date) : duckdb_state;

    extern proc duckdb_append_time(appender : duckdb_appender, in value : duckdb_time) : duckdb_state;

    extern proc duckdb_append_timestamp(appender : duckdb_appender, in value : duckdb_timestamp) : duckdb_state;

    extern proc duckdb_append_interval(appender : duckdb_appender, in value : duckdb_interval) : duckdb_state;

    extern proc duckdb_append_varchar(appender : duckdb_appender, val : c_ptrConst(c_char)) : duckdb_state;

    extern proc duckdb_append_varchar_length(appender : duckdb_appender, val : c_ptrConst(c_char), length : idx_t) : duckdb_state;

    extern proc duckdb_append_blob(appender : duckdb_appender, data : c_ptrConst(void), length : idx_t) : duckdb_state;

    extern proc duckdb_append_null(appender : duckdb_appender) : duckdb_state;

    extern proc duckdb_append_data_chunk(appender : duckdb_appender, chunk : duckdb_data_chunk) : duckdb_state;

    extern proc duckdb_table_description_create(connection : duckdb_connection, schema : c_ptrConst(c_char), table : c_ptrConst(c_char), ref out_arg : duckdb_table_description) : duckdb_state;

    extern proc duckdb_table_description_create(connection : duckdb_connection, schema : c_ptrConst(c_char), table : c_ptrConst(c_char), out_arg : c_ptr(duckdb_table_description)) : duckdb_state;

    extern proc duckdb_table_description_destroy(ref table_description : duckdb_table_description) : void;

    extern proc duckdb_table_description_destroy(table_description : c_ptr(duckdb_table_description)) : void;

    extern proc duckdb_table_description_error(table_description : duckdb_table_description) : c_ptrConst(c_char);

    extern proc duckdb_column_has_default(table_description : duckdb_table_description, index_arg : idx_t, ref out_arg : bool) : duckdb_state;

    extern proc duckdb_column_has_default(table_description : duckdb_table_description, index_arg : idx_t, out_arg : c_ptr(bool)) : duckdb_state;

    extern proc duckdb_query_arrow(connection : duckdb_connection, query : c_ptrConst(c_char), ref out_result : duckdb_arrow) : duckdb_state;

    extern proc duckdb_query_arrow(connection : duckdb_connection, query : c_ptrConst(c_char), out_result : c_ptr(duckdb_arrow)) : duckdb_state;

    extern proc duckdb_query_arrow_schema(result : duckdb_arrow, ref out_schema : duckdb_arrow_schema) : duckdb_state;

    extern proc duckdb_query_arrow_schema(result : duckdb_arrow, out_schema : c_ptr(duckdb_arrow_schema)) : duckdb_state;

    extern proc duckdb_prepared_arrow_schema(prepared : duckdb_prepared_statement, ref out_schema : duckdb_arrow_schema) : duckdb_state;

    extern proc duckdb_prepared_arrow_schema(prepared : duckdb_prepared_statement, out_schema : c_ptr(duckdb_arrow_schema)) : duckdb_state;

    extern proc duckdb_result_arrow_array(in result : duckdb_result, chunk : duckdb_data_chunk, ref out_array : duckdb_arrow_array) : void;

    extern proc duckdb_result_arrow_array(in result : duckdb_result, chunk : duckdb_data_chunk, out_array : c_ptr(duckdb_arrow_array)) : void;

    extern proc duckdb_query_arrow_array(result : duckdb_arrow, ref out_array : duckdb_arrow_array) : duckdb_state;

    extern proc duckdb_query_arrow_array(result : duckdb_arrow, out_array : c_ptr(duckdb_arrow_array)) : duckdb_state;

    extern proc duckdb_arrow_column_count(result : duckdb_arrow) : idx_t;

    extern proc duckdb_arrow_row_count(result : duckdb_arrow) : idx_t;

    extern proc duckdb_arrow_rows_changed(result : duckdb_arrow) : idx_t;

    extern proc duckdb_query_arrow_error(result : duckdb_arrow) : c_ptrConst(c_char);

    extern proc duckdb_destroy_arrow(ref result : duckdb_arrow) : void;

    extern proc duckdb_destroy_arrow(result : c_ptr(duckdb_arrow)) : void;

    extern proc duckdb_destroy_arrow_stream(ref stream_p : duckdb_arrow_stream) : void;

    extern proc duckdb_destroy_arrow_stream(stream_p : c_ptr(duckdb_arrow_stream)) : void;

    extern proc duckdb_execute_prepared_arrow(prepared_statement : duckdb_prepared_statement, ref out_result : duckdb_arrow) : duckdb_state;

    extern proc duckdb_execute_prepared_arrow(prepared_statement : duckdb_prepared_statement, out_result : c_ptr(duckdb_arrow)) : duckdb_state;

    extern proc duckdb_arrow_scan(connection : duckdb_connection, table_name : c_ptrConst(c_char), arrow : duckdb_arrow_stream) : duckdb_state;

    extern proc duckdb_arrow_array_scan(connection : duckdb_connection, table_name : c_ptrConst(c_char), arrow_schema : duckdb_arrow_schema, arrow_array : duckdb_arrow_array, ref out_stream : duckdb_arrow_stream) : duckdb_state;

    extern proc duckdb_arrow_array_scan(connection : duckdb_connection, table_name : c_ptrConst(c_char), arrow_schema : duckdb_arrow_schema, arrow_array : duckdb_arrow_array, out_stream : c_ptr(duckdb_arrow_stream)) : duckdb_state;

    extern proc duckdb_execute_tasks(database : duckdb_database, max_tasks : idx_t) : void;

    extern proc duckdb_create_task_state(database : duckdb_database) : duckdb_task_state;

    extern proc duckdb_execute_tasks_state(state : duckdb_task_state) : void;

    extern proc duckdb_execute_n_tasks_state(state : duckdb_task_state, max_tasks : idx_t) : idx_t;

    extern proc duckdb_finish_execution(state : duckdb_task_state) : void;

    extern proc duckdb_task_state_is_finished(state : duckdb_task_state) : bool;

    extern proc duckdb_destroy_task_state(state : duckdb_task_state) : void;

    extern proc duckdb_execution_is_finished(con : duckdb_connection) : bool;

    extern proc duckdb_stream_fetch_chunk(in result : duckdb_result) : duckdb_data_chunk;

    extern proc duckdb_fetch_chunk(in result : duckdb_result) : duckdb_data_chunk;

    extern proc duckdb_create_cast_function() : duckdb_cast_function;

    extern proc duckdb_cast_function_set_source_type(cast_function : duckdb_cast_function, source_type : duckdb_logical_type) : void;

    extern proc duckdb_cast_function_set_target_type(cast_function : duckdb_cast_function, target_type : duckdb_logical_type) : void;

    extern proc duckdb_cast_function_set_implicit_cast_cost(cast_function : duckdb_cast_function, cost : int(64)) : void;

    extern proc duckdb_cast_function_set_function(cast_function : duckdb_cast_function, function : duckdb_cast_function_t) : void;

    extern proc duckdb_cast_function_set_extra_info(cast_function : duckdb_cast_function, extra_info : c_ptr(void), destroy : duckdb_delete_callback_t) : void;

    extern proc duckdb_cast_function_get_extra_info(info : duckdb_function_info) : c_ptr(void);

    extern proc duckdb_cast_function_get_cast_mode(info : duckdb_function_info) : duckdb_cast_mode;

    extern proc duckdb_cast_function_set_error(info : duckdb_function_info, error : c_ptrConst(c_char)) : void;

    extern proc duckdb_cast_function_set_row_error(info : duckdb_function_info, error : c_ptrConst(c_char), row : idx_t, output : duckdb_vector) : void;

    extern proc duckdb_register_cast_function(con : duckdb_connection, cast_function : duckdb_cast_function) : duckdb_state;

    extern proc duckdb_destroy_cast_function(ref cast_function : duckdb_cast_function) : void;

    extern proc duckdb_destroy_cast_function(cast_function : c_ptr(duckdb_cast_function)) : void;

    // ==== c2chapel typedefs ====

    extern type duckdb_aggregate_combine_t = c_fn_ptr;

    extern type duckdb_aggregate_destroy_t = c_fn_ptr;

    extern type duckdb_aggregate_finalize_t = c_fn_ptr;

    // Typedef'd pointer to struct
    extern type duckdb_aggregate_function;

    // Typedef'd pointer to struct
    extern type duckdb_aggregate_function_set;

    extern type duckdb_aggregate_init_t = c_fn_ptr;

    // Typedef'd pointer to struct
    extern type duckdb_aggregate_state;

    extern type duckdb_aggregate_state_size = c_fn_ptr;

    extern type duckdb_aggregate_update_t = c_fn_ptr;

    // Typedef'd pointer to struct
    extern type duckdb_appender;

    // Typedef'd pointer to struct
    extern type duckdb_arrow;

    // Typedef'd pointer to struct
    extern type duckdb_arrow_array;

    // Typedef'd pointer to struct
    extern type duckdb_arrow_schema;

    // Typedef'd pointer to struct
    extern type duckdb_arrow_stream;

    // Typedef'd pointer to struct
    extern type duckdb_bind_info;

    extern record duckdb_blob {
    var data : c_ptr(void);
    var size : idx_t;
    }

    // Typedef'd pointer to struct
    extern type duckdb_cast_function;

    extern type duckdb_cast_function_t = c_fn_ptr;

    // duckdb_cast_mode enum
    extern type duckdb_cast_mode = c_int;
    extern const DUCKDB_CAST_NORMAL :duckdb_cast_mode;
    extern const DUCKDB_CAST_TRY :duckdb_cast_mode;


    extern record duckdb_column {
    var deprecated_data : c_ptr(void);
    var deprecated_nullmask : c_ptr(bool);
    var deprecated_type : duckdb_type;
    var deprecated_name : c_ptr(c_char);
    var internal_data : c_ptr(void);
    }

    // Typedef'd pointer to struct
    extern type duckdb_config;

    // Typedef'd pointer to struct
    extern type duckdb_connection;

    // Typedef'd pointer to struct
    extern type duckdb_create_type_info;

    // Typedef'd pointer to struct
    extern type duckdb_data_chunk;

    // Typedef'd pointer to struct
    extern type duckdb_database;

    extern record duckdb_date {
    var days : int(32);
    }

    extern record duckdb_date_struct {
    var year : int(32);
    var month : int(8);
    var day : int(8);
    }

    extern record duckdb_decimal {
    var width : uint(8);
    var scale : uint(8);
    var value : duckdb_hugeint;
    }

    extern type duckdb_delete_callback_t = c_fn_ptr;

    // duckdb_error_type enum
    extern type duckdb_error_type = c_int;
    extern const DUCKDB_ERROR_INVALID :duckdb_error_type;
    extern const DUCKDB_ERROR_OUT_OF_RANGE :duckdb_error_type;
    extern const DUCKDB_ERROR_CONVERSION :duckdb_error_type;
    extern const DUCKDB_ERROR_UNKNOWN_TYPE :duckdb_error_type;
    extern const DUCKDB_ERROR_DECIMAL :duckdb_error_type;
    extern const DUCKDB_ERROR_MISMATCH_TYPE :duckdb_error_type;
    extern const DUCKDB_ERROR_DIVIDE_BY_ZERO :duckdb_error_type;
    extern const DUCKDB_ERROR_OBJECT_SIZE :duckdb_error_type;
    extern const DUCKDB_ERROR_INVALID_TYPE :duckdb_error_type;
    extern const DUCKDB_ERROR_SERIALIZATION :duckdb_error_type;
    extern const DUCKDB_ERROR_TRANSACTION :duckdb_error_type;
    extern const DUCKDB_ERROR_NOT_IMPLEMENTED :duckdb_error_type;
    extern const DUCKDB_ERROR_EXPRESSION :duckdb_error_type;
    extern const DUCKDB_ERROR_CATALOG :duckdb_error_type;
    extern const DUCKDB_ERROR_PARSER :duckdb_error_type;
    extern const DUCKDB_ERROR_PLANNER :duckdb_error_type;
    extern const DUCKDB_ERROR_SCHEDULER :duckdb_error_type;
    extern const DUCKDB_ERROR_EXECUTOR :duckdb_error_type;
    extern const DUCKDB_ERROR_CONSTRAINT :duckdb_error_type;
    extern const DUCKDB_ERROR_INDEX :duckdb_error_type;
    extern const DUCKDB_ERROR_STAT :duckdb_error_type;
    extern const DUCKDB_ERROR_CONNECTION :duckdb_error_type;
    extern const DUCKDB_ERROR_SYNTAX :duckdb_error_type;
    extern const DUCKDB_ERROR_SETTINGS :duckdb_error_type;
    extern const DUCKDB_ERROR_BINDER :duckdb_error_type;
    extern const DUCKDB_ERROR_NETWORK :duckdb_error_type;
    extern const DUCKDB_ERROR_OPTIMIZER :duckdb_error_type;
    extern const DUCKDB_ERROR_NULL_POINTER :duckdb_error_type;
    extern const DUCKDB_ERROR_IO :duckdb_error_type;
    extern const DUCKDB_ERROR_INTERRUPT :duckdb_error_type;
    extern const DUCKDB_ERROR_FATAL :duckdb_error_type;
    extern const DUCKDB_ERROR_INTERNAL :duckdb_error_type;
    extern const DUCKDB_ERROR_INVALID_INPUT :duckdb_error_type;
    extern const DUCKDB_ERROR_OUT_OF_MEMORY :duckdb_error_type;
    extern const DUCKDB_ERROR_PERMISSION :duckdb_error_type;
    extern const DUCKDB_ERROR_PARAMETER_NOT_RESOLVED :duckdb_error_type;
    extern const DUCKDB_ERROR_PARAMETER_NOT_ALLOWED :duckdb_error_type;
    extern const DUCKDB_ERROR_DEPENDENCY :duckdb_error_type;
    extern const DUCKDB_ERROR_HTTP :duckdb_error_type;
    extern const DUCKDB_ERROR_MISSING_EXTENSION :duckdb_error_type;
    extern const DUCKDB_ERROR_AUTOLOAD :duckdb_error_type;
    extern const DUCKDB_ERROR_SEQUENCE :duckdb_error_type;
    extern const DUCKDB_INVALID_CONFIGURATION :duckdb_error_type;


    // Typedef'd pointer to struct
    extern type duckdb_extension_info;

    // Typedef'd pointer to struct
    extern type duckdb_extracted_statements;

    // Typedef'd pointer to struct
    extern type duckdb_function_info;

    extern record duckdb_hugeint {
    var lower : uint(64);
    var upper : int(64);
    }

    // Typedef'd pointer to struct
    extern type duckdb_init_info;

    extern record duckdb_interval {
    var months : int(32);
    var days : int(32);
    var micros : int(64);
    }

    extern record duckdb_list_entry {
    var offset : uint(64);
    var length : uint(64);
    }

    // Typedef'd pointer to struct
    extern type duckdb_logical_type;

    // Typedef'd pointer to struct
    extern type duckdb_pending_result;

    // duckdb_pending_state enum
    extern type duckdb_pending_state = c_int;
    extern const DUCKDB_PENDING_RESULT_READY :duckdb_pending_state;
    extern const DUCKDB_PENDING_RESULT_NOT_READY :duckdb_pending_state;
    extern const DUCKDB_PENDING_ERROR :duckdb_pending_state;
    extern const DUCKDB_PENDING_NO_TASKS_AVAILABLE :duckdb_pending_state;


    // Typedef'd pointer to struct
    extern type duckdb_prepared_statement;

    // Typedef'd pointer to struct
    extern type duckdb_profiling_info;

    extern record duckdb_query_progress_type {
    var percentage : c_double;
    var rows_processed : uint(64);
    var total_rows_to_process : uint(64);
    }

    extern type duckdb_replacement_callback_t = c_fn_ptr;

    // Typedef'd pointer to struct
    extern type duckdb_replacement_scan_info;

    extern record duckdb_result {
    var deprecated_column_count : idx_t;
    var deprecated_row_count : idx_t;
    var deprecated_rows_changed : idx_t;
    var deprecated_columns : c_ptr(duckdb_column);
    var deprecated_error_message : c_ptr(c_char);
    var internal_data : c_ptr(void);
    }

    // duckdb_result_type enum
    extern type duckdb_result_type = c_int;
    extern const DUCKDB_RESULT_TYPE_INVALID :duckdb_result_type;
    extern const DUCKDB_RESULT_TYPE_CHANGED_ROWS :duckdb_result_type;
    extern const DUCKDB_RESULT_TYPE_NOTHING :duckdb_result_type;
    extern const DUCKDB_RESULT_TYPE_QUERY_RESULT :duckdb_result_type;


    // Typedef'd pointer to struct
    extern type duckdb_scalar_function;

    // Typedef'd pointer to struct
    extern type duckdb_scalar_function_set;

    extern type duckdb_scalar_function_t = c_fn_ptr;

    // duckdb_state enum
    extern type duckdb_state = c_int;
    extern const DuckDBSuccess :duckdb_state;
    extern const DuckDBError :duckdb_state;


    // duckdb_statement_type enum
    extern type duckdb_statement_type = c_int;
    extern const DUCKDB_STATEMENT_TYPE_INVALID :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_SELECT :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_INSERT :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_UPDATE :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_EXPLAIN :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_DELETE :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_PREPARE :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_CREATE :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_EXECUTE :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_ALTER :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_TRANSACTION :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_COPY :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_ANALYZE :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_VARIABLE_SET :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_CREATE_FUNC :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_DROP :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_EXPORT :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_PRAGMA :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_VACUUM :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_CALL :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_SET :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_LOAD :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_RELATION :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_EXTENSION :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_LOGICAL_PLAN :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_ATTACH :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_DETACH :duckdb_statement_type;
    extern const DUCKDB_STATEMENT_TYPE_MULTI :duckdb_statement_type;


    extern record duckdb_string {
    var data : c_ptr(c_char);
    var size : idx_t;
    }

    // Anonymous union or struct was encountered within and skipped.
    extern record duckdb_string_t {}

    // Typedef'd pointer to struct
    extern type duckdb_table_description;

    // Typedef'd pointer to struct
    extern type duckdb_table_function;

    extern type duckdb_table_function_bind_t = c_fn_ptr;

    extern type duckdb_table_function_init_t = c_fn_ptr;

    extern type duckdb_table_function_t = c_fn_ptr;

    extern type duckdb_task_state = c_ptr(void);

    extern record duckdb_time {
    var micros : int(64);
    }

    extern record duckdb_time_struct {
    var hour : int(8);
    var min : int(8);
    var sec : int(8);
    var micros : int(32);
    }

    extern record duckdb_time_tz {
    var bits : uint(64);
    }

    extern record duckdb_time_tz_struct {
    var time : duckdb_time_struct;
    var offset : int(32);
    }

    extern record duckdb_timestamp {
    var micros : int(64);
    }

    extern record duckdb_timestamp_struct {
    var date : duckdb_date_struct;
    var time : duckdb_time_struct;
    }

    // duckdb_type enum
    extern type duckdb_type = c_int;
    extern const DUCKDB_TYPE_INVALID :duckdb_type;
    extern const DUCKDB_TYPE_BOOLEAN :duckdb_type;
    extern const DUCKDB_TYPE_TINYINT :duckdb_type;
    extern const DUCKDB_TYPE_SMALLINT :duckdb_type;
    extern const DUCKDB_TYPE_INTEGER :duckdb_type;
    extern const DUCKDB_TYPE_BIGINT :duckdb_type;
    extern const DUCKDB_TYPE_UTINYINT :duckdb_type;
    extern const DUCKDB_TYPE_USMALLINT :duckdb_type;
    extern const DUCKDB_TYPE_UINTEGER :duckdb_type;
    extern const DUCKDB_TYPE_UBIGINT :duckdb_type;
    extern const DUCKDB_TYPE_FLOAT :duckdb_type;
    extern const DUCKDB_TYPE_DOUBLE :duckdb_type;
    extern const DUCKDB_TYPE_TIMESTAMP :duckdb_type;
    extern const DUCKDB_TYPE_DATE :duckdb_type;
    extern const DUCKDB_TYPE_TIME :duckdb_type;
    extern const DUCKDB_TYPE_INTERVAL :duckdb_type;
    extern const DUCKDB_TYPE_HUGEINT :duckdb_type;
    extern const DUCKDB_TYPE_UHUGEINT :duckdb_type;
    extern const DUCKDB_TYPE_VARCHAR :duckdb_type;
    extern const DUCKDB_TYPE_BLOB :duckdb_type;
    extern const DUCKDB_TYPE_DECIMAL :duckdb_type;
    extern const DUCKDB_TYPE_TIMESTAMP_S :duckdb_type;
    extern const DUCKDB_TYPE_TIMESTAMP_MS :duckdb_type;
    extern const DUCKDB_TYPE_TIMESTAMP_NS :duckdb_type;
    extern const DUCKDB_TYPE_ENUM :duckdb_type;
    extern const DUCKDB_TYPE_LIST :duckdb_type;
    extern const DUCKDB_TYPE_STRUCT :duckdb_type;
    extern const DUCKDB_TYPE_MAP :duckdb_type;
    extern const DUCKDB_TYPE_ARRAY :duckdb_type;
    extern const DUCKDB_TYPE_UUID :duckdb_type;
    extern const DUCKDB_TYPE_UNION :duckdb_type;
    extern const DUCKDB_TYPE_BIT :duckdb_type;
    extern const DUCKDB_TYPE_TIME_TZ :duckdb_type;
    extern const DUCKDB_TYPE_TIMESTAMP_TZ :duckdb_type;
    extern const DUCKDB_TYPE_ANY :duckdb_type;
    extern const DUCKDB_TYPE_VARINT :duckdb_type;
    extern const DUCKDB_TYPE_SQLNULL :duckdb_type;


    extern record duckdb_uhugeint {
    var lower : uint(64);
    var upper : uint(64);
    }

    // Typedef'd pointer to struct
    extern type duckdb_value;

    // Typedef'd pointer to struct
    extern type duckdb_vector;

    extern type idx_t = uint(64);

    // c2chapel thinks these typedefs are from the fake headers:
    /*
    extern type FILE = c_int;

    // Opaque struct?
    extern record MirBlob {};

    // Opaque struct?
    extern record MirBufferStream {};

    // Opaque struct?
    extern record MirConnection {};

    // Opaque struct?
    extern record MirDisplayConfig {};

    extern type MirEGLNativeDisplayType = c_ptr(void);

    extern type MirEGLNativeWindowType = c_ptr(void);

    // Opaque struct?
    extern record MirPersistentId {};

    // Opaque struct?
    extern record MirPromptSession {};

    // Opaque struct?
    extern record MirScreencast {};

    // Opaque struct?
    extern record MirSurface {};

    // Opaque struct?
    extern record MirSurfaceSpec {};

    extern type _LOCK_RECURSIVE_T = c_int;

    extern type _LOCK_T = c_int;

    extern type __FILE = c_int;

    extern type __ULong = c_int;

    extern type __builtin_va_list = c_int;

    extern type __dev_t = c_int;

    extern type __gid_t = c_int;

    extern type __gnuc_va_list = c_int;

    extern type __int16_t = c_int;

    extern type __int32_t = c_int;

    extern type __int64_t = c_int;

    extern type __int8_t = c_int;

    extern type __int_least16_t = c_int;

    extern type __int_least32_t = c_int;

    extern type __loff_t = c_int;

    extern type __off_t = c_int;

    extern type __pid_t = c_int;

    extern type __s16 = c_int;

    extern type __s32 = c_int;

    extern type __s64 = c_int;

    extern type __s8 = c_int;

    extern type __sigset_t = c_int;

    extern type __tzinfo_type = c_int;

    extern type __tzrule_type = c_int;

    extern type __u16 = c_int;

    extern type __u32 = c_int;

    extern type __u64 = c_int;

    extern type __u8 = c_int;

    extern type __uid_t = c_int;

    extern type __uint16_t = c_int;

    extern type __uint32_t = c_int;

    extern type __uint64_t = c_int;

    extern type __uint8_t = c_int;

    extern type __uint_least16_t = c_int;

    extern type __uint_least32_t = c_int;

    extern type _flock_t = c_int;

    extern type _fpos_t = c_int;

    extern type _iconv_t = c_int;

    extern type _mbstate_t = c_int;

    extern type _off64_t = c_int;

    extern type _off_t = c_int;

    extern type _sig_func_ptr = c_int;

    extern type _ssize_t = c_int;

    extern type _types_fd_set = c_int;

    extern type bool = _Bool;

    extern type caddr_t = c_int;

    extern type clock_t = c_int;

    extern type clockid_t = c_int;

    extern type cookie_close_function_t = c_int;

    extern type cookie_io_functions_t = c_int;

    extern type cookie_read_function_t = c_int;

    extern type cookie_seek_function_t = c_int;

    extern type cookie_write_function_t = c_int;

    extern type daddr_t = c_int;

    extern type dev_t = c_int;

    extern type div_t = c_int;

    extern type fd_mask = c_int;

    extern type fpos_t = c_int;

    extern type gid_t = c_int;

    extern type ino_t = c_int;

    extern type int16_t = c_int;

    extern type int32_t = c_int;

    extern type int64_t = c_int;

    extern type int8_t = c_int;

    extern type int_fast16_t = c_int;

    extern type int_fast32_t = c_int;

    extern type int_fast64_t = c_int;

    extern type int_fast8_t = c_int;

    extern type int_least16_t = c_int;

    extern type int_least32_t = c_int;

    extern type int_least64_t = c_int;

    extern type int_least8_t = c_int;

    extern type intmax_t = c_int;

    extern type intptr_t = c_int;

    extern type jmp_buf = c_int;

    extern type key_t = c_int;

    extern type ldiv_t = c_int;

    extern type lldiv_t = c_int;

    extern type mbstate_t = c_int;

    extern type mode_t = c_int;

    extern type nlink_t = c_int;

    extern type off_t = c_int;

    extern type pid_t = c_int;

    extern type pthread_attr_t = c_int;

    extern type pthread_barrier_t = c_int;

    extern type pthread_barrierattr_t = c_int;

    extern type pthread_cond_t = c_int;

    extern type pthread_condattr_t = c_int;

    extern type pthread_key_t = c_int;

    extern type pthread_mutex_t = c_int;

    extern type pthread_mutexattr_t = c_int;

    extern type pthread_once_t = c_int;

    extern type pthread_rwlock_t = c_int;

    extern type pthread_rwlockattr_t = c_int;

    extern type pthread_spinlock_t = c_int;

    extern type pthread_t = c_int;

    extern type ptrdiff_t = c_int;

    extern type rlim_t = c_int;

    extern type sa_family_t = c_int;

    extern type sem_t = c_int;

    extern type sig_atomic_t = c_int;

    extern type siginfo_t = c_int;

    extern type sigjmp_buf = c_int;

    extern type sigset_t = c_int;

    extern type size_t = c_int;

    extern type ssize_t = c_int;

    extern type stack_t = c_int;

    extern type suseconds_t = c_int;

    extern type time_t = c_int;

    extern type timer_t = c_int;

    extern type u_char = c_int;

    extern type u_int = c_int;

    extern type u_long = c_int;

    extern type u_short = c_int;

    extern type uid_t = c_int;

    extern type uint = c_int;

    extern type uint16_t = c_int;

    extern type uint32_t = c_int;

    extern type uint64_t = c_int;

    extern type uint8_t = c_int;

    extern type uint_fast16_t = c_int;

    extern type uint_fast32_t = c_int;

    extern type uint_fast64_t = c_int;

    extern type uint_fast8_t = c_int;

    extern type uint_least16_t = c_int;

    extern type uint_least32_t = c_int;

    extern type uint_least64_t = c_int;

    extern type uint_least8_t = c_int;

    extern type uintmax_t = c_int;

    extern type uintptr_t = c_int;

    extern type useconds_t = c_int;

    extern type ushort = c_int;

    extern type va_list = c_int;

    extern type wchar_t = c_int;

    extern type wint_t = c_int;

    // Opaque struct?
    extern record xcb_connection_t {};

    extern type xcb_visualid_t = uint(32);

    extern type xcb_window_t = uint(32);

    extern type z_stream = c_int;

    */
}
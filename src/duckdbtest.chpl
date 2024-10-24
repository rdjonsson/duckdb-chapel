use IO;
use DuckDB;
use CTypes;

var db: duckdb_database;
var inMemory: c_ptrConst(c_char);
var con: duckdb_connection;
var state: duckdb_state;
var res: duckdb_result;


var open_response = duckdb_open(nil, db);


var connect_response = duckdb_connect(db, con);


state = duckdb_query(con, "select 2342 as testcol;", res);

do {

    var result = duckdb_fetch_chunk(res);
    
    var row_count = duckdb_data_chunk_get_size(result);
    
    if row_count == 0 then break;
    writeln(row_count);
    
    var col1 = duckdb_data_chunk_get_vector(result, 0);
    var ctype = duckdb_vector_get_column_type(col1);
    var typeid = duckdb_get_type_id(ctype);
    if typeid == DUCKDB_TYPE_INTEGER {

        writeln(typeid);
        var col1_data = duckdb_vector_get_data(col1):c_ptr(int(32));
        var col1_validity = duckdb_vector_get_validity(col1);
        for row in 0..<row_count {
            if duckdb_validity_row_is_valid(col1_validity, row) {
                writeln(col1_data[row]:int);
            } else {
                writeln("NULL");
            }
            writeln("\n");
        }
    }


    duckdb_destroy_data_chunk(result);

} while true;

duckdb_disconnect(con);
duckdb_close(db);
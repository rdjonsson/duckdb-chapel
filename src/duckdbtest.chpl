use IO;
use DuckDB;
use CTypes;

var db: duckdb_database;
var inMemory: c_ptrConst(c_char);
var con: duckdb_connection;
var state: duckdb_state;
var result: duckdb_result;


var open_response = duckdb_open(nil, db);
writeln("here");
writeln(open_response);


var connect_response = duckdb_connect(db, con);
writeln(connect_response);


state = duckdb_query(con, "select 1231 as testcol;", result);



writeln(result);

duckdb_disconnect(con);
duckdb_close(db);
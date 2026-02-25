use DuckDB;

proc main() throws {
  var db = openDatabase(":memory:");
  var conn = connect(db);

  conn.execute(
    "CREATE TABLE sensors (\
       id INTEGER, name VARCHAR, temperature DOUBLE, active BOOLEAN\
     )");
  conn.execute(
    "INSERT INTO sensors VALUES\
       (1, 'north',  22.5, true),\
       (2, 'south',  18.3, true),\
       (3, 'east',   25.1, false),\
       (4, 'west',   20.7, true)");

  // Get results as a dataframe
  var df = conn.queryToDataframe("SELECT * FROM sensors ORDER BY id");

  writeln("Shape: ", df.numRows(), " rows x ", df.numCols(), " cols");
  writeln("Columns: ", df.columnNames());
  writeln();

  // Access entire columns as arrays by name
  var ids   = df.getIntColumn("id");
  var names = df.getStringColumn("name");
  var temps = df.getDoubleColumn("temperature");

  writeln("IDs:          ", ids);
  writeln("Names:        ", names);
  writeln("Temperatures: ", temps);
  writeln();

  // Access by column index
  var activeFlags = df.getBoolColumn(3);
  writeln("Active: ", activeFlags);
  writeln();

  // Access individual column object for row-level iteration
  var tempCol = df.column("temperature");
  var maxTemp = -999.0;
  for row in 0..<df.numRows() {
    if !tempCol.isNull(row) && tempCol.getDouble(row) > maxTemp {
      maxTemp = tempCol.getDouble(row);
    }
  }
  writeln("Max temperature: ", maxTemp);
}

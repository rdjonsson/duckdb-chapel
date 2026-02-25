# duckdb-chapel

Status: some initial testing of using the DuckDB C api in Chapel.

Status update (Feb 2026): Read into records. Vibe coded using Claude Opus, via Kagi Assistant. Also included a simple dataframe type to alternatively return typed and named columns from a table.


## User story

I'd eventually like something like this to work:

- A command to open and connect to a database either in-memory or on file. **[done]**
- A simple command to send queries to the database **[done]**
- A command to run a query against the database and use the columns from the query as vectors and domains connected to the vector. See data example below. **[partly done]**

Example data:


|orig |dest |value  |
|-----|-----|-------|
| 0   | 0   | 2     |
| 1   | 0   | 3     |
| 0   | 1   | 5     |
| 1   | 1   | 7     |


Usage example

```chapel
record Agent {
  var AgentId: int;
  var HouseholdId: int;
  var BirthYear: int;
}

proc main() throws {
  var db = openDatabase(":memory:");
  var conn = connect(db);

  // Create and populate test table
  conn.execute("CREATE TABLE agents (id INTEGER, hh_id INTEGER, year INTEGER)");
  conn.execute("INSERT INTO agents VALUES (1, 100, 1985)");
  conn.execute("INSERT INTO agents VALUES (2, 100, 1987)");
  conn.execute("INSERT INTO agents VALUES (3, 101, 1990)");

  // Usage 1: Fetch into array of records, columns matched by order
  writeln("Fetch into array - columns must be in same order as record fields");
  var agents1 = conn.fetchAll(Agent, 
    "SELECT id, hh_id, year FROM agents ORDER BY id");

  for agent in agents1 {
    writeln("Agent ", agent.AgentId, 
            " in household ", agent.HouseholdId,
            " born ", agent.BirthYear);
  }

  // Usage 2: Fetch into array of records, columns matched by mapping
  writeln("Fetch into array - columns matched by mapping");

  // Define mapping: (sql_column_name, record_field_name)
  var mapping: [0..2] (string, string) = [
    ("id", "AgentId"),
    ("hh_id", "HouseholdId"),
    ("year", "BirthYear")
  ];

  var agents2 = conn.fetchAllMapped(Agent,
    "SELECT id, year, hh_id FROM agents ORDER BY id",
    mapping);

  for agent in agents2 {
    writeln(agent);
  }


}
```

Writing data is of lower priority. It would probably be more useful with a straightforward Parquet writer instead.
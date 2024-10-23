# duckdb-chapel

Status: some initial testing of using the DuckDB C api in Chapel.

Compiling with
```bash
chpl -o bin/duckdbtest --ccflags -Wno-strict-prototypes duckdbtest.chpl
```

## User story

I'd eventually like something like this to work:

- A command to open and connect to a database either in-memory or on file.
- A simple command to send queries to the database
- A command to run a query against the database and use the columns from the query as vectors and domains connected to the vector. See data example below.

Example data:


|orig |dest |value  |
|-----|-----|-------|
| 0   | 0   | 2     |
| 1   | 0   | 3     |
| 0   | 1   | 5     |
| 1   | 1   | 7     |

Writing data is of lower priority. It would probably be more useful with a straightforward Parquet writer instead.
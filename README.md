# duckdb-chapel

Status: some initial testing of using the DuckDB C api in Chapel.

Compiling with
```bash
chpl -o bin/duckdbtest --ccflags -Wno-strict-prototypes duckdbtest.chpl
```
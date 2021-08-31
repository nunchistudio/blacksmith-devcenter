---
title: Selects
enterprise: false
---

# Selects

A *select* executes a query that returns rows, typically a `SELECT`. As the name
suggests, queries should be used for `SELECT`ing samples of data.

This can be achived with the [`run select`](/blacksmith/cli/run-select) command:
```bash
$ blacksmith run select \
  --integration warehouse \
  --file ./warehouse/selects/demo.sql

Compiling & Running queries:

  -> Compiling & Running ./warehouse/selects/demo.sql...
     Success!
```

This command runs the content of the file `demo.sql`, which must be a SQL query
returning rows.

**Running a template directly against your database without knowing the compiled
query can be tedious.** We strongly advise to first use the `--dry-run` flag,
which compiles the SQL file under a new file named `<query>.compiled.sql`. This
file is located at the same path than the template one.

If we want to make the same run as the previous one but much more safely, we first
compile the SQL file using the `--dry-run` flag:
```bash
$ blacksmith run select \
  --integration warehouse \
  --file ./warehouse/selects/demo.sql \
  --dry-run

Compiling queries:

  -> Compiling ./warehouse/selects/demo.sql...
     Success!
```

After making sure the compiled SQL query is correct, we can run it and download
the returned rows both [as CSV](/blacksmith/sqlstores/transformations/selects-csv)
and [as JSON](/blacksmith/sqlstores/transformations/selects-json) files:
```bash
$ blacksmith run select \
  --integration warehouse \
  --file ./warehouse/selects/demo.sql \
  --csv --json

Compiling & Running queries:

  -> Compiling & Running ./warehouse/selects/demo.sql...
     Writing CSV at ./selects/warehouse/demo.csv...
     Writing JSON at ./selects/warehouse/demo.json...
     Success!
```

---
title: Operations
enterprise: false
---

# Operations

An *operation* executes a query without returning any rows. When running an
operation, it is automatically wrapped inside a transaction to ensure it is either
entirely commited or rolled back if any error occured. Operations should be used
for managing / refreshing views (materialized or not).

This can be achived with the [`run operation`](/blacksmith/cli/run-operation)
command:
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file ./warehouse/operations/demo.sql

Compiling & Running queries:

  -> Compiling & Running ./warehouse/operations/demo.sql...
     Success!
```

This command runs the content of the file `demo.sql`, which must be a SQL query
not returning rows.

**Running a template directly against your database without knowing the compiled
query can be tedious.** We strongly advise to first use the `--dry-run` flag,
which compiles the SQL file under a new file named `<query>.compiled.sql`. This
file is located at the same path than the template one.

If we want to make the same run as the previous one but much more safely, we first
compile the SQL file using the `--dry-run` flag:
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file ./warehouse/operations/demo.sql \
  --dry-run

Compiling queries:

  -> Compiling ./warehouse/operations/demo.sql...
     Success!
```

After making sure the compiled SQL query is correct, we can run it:
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file ./warehouse/operations/demo.sql

Compiling & Running queries:

  -> Compiling & Running ./warehouse/operations/demo.sql...
     Success!
```

You can pass data [from a CSV](/blacksmith/sqlstores/transformations/operations-csv)
or [from a JSON](/blacksmith/sqlstores/transformations/operations-json) file.

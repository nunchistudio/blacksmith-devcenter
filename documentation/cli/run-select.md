---
title: blacksmith run select
enterprise: false
---

# `blacksmith run select`

This command runs a query on top of a SQL database, returning rows.

**Example:**
```bash
$ blacksmith run select \
  --integration warehouse \
  --file "./queries/demo.sql" \
  --data "./data/somedata.json" \
  --csv --json
```

## Required flags

- `--integration [integration]`: Integration to run the query against.

  **Aliases:** `-i [integration]`

  **Example:**
  ```bash
  $ blacksmith run select \
    --integration warehouse \
    --file "./operations/demo.sql"
  ```

- `--file [filename]`: The relative path to the SQL file to compile and execute
  against the database.

  **Aliases:** `-f [filename]`

  **Example:**
  ```bash
  $ blacksmith run select \
    --integration warehouse \
    --file "./operations/demo.sql"
  ```

## Optional flags

- `--data [filename]`: The relative path to the CSV or JSON file to pass down to
  the SQL template file as data source.

  **Aliases:** `-d [filename]`

  **Example:**
  ```bash
  $ blacksmith run select \
    --integration warehouse \
    --file "./operations/demo.sql" \
    --data "./data/somedata.json"
  ```

- `--dryrun`: Only compile the SQL file into `<select>.compiled.sql` at the same
  location of the template file. This prevents the query to actually run.

  **Aliases:** `-dr`

  **Example:**
  ```bash
  $ blacksmith run select \
    --integration warehouse \
    --file "./operations/demo.sql" \
    --dryrun
  ```

- `--csv`: Download the result as a CSV file. The file is written as
  `<query>.csv` at the same location of the SQL file. This does not apply if
  the flag `--dryrun` is passed as well.

  **Example:**
  ```bash
  $ blacksmith run query \
    --integration warehouse \
    --file "./queries/demo.sql" \
    --csv
  ```

- `--json`: Download the result as a JSON file. The file is written as
  `<query>.json` at the same location of the SQL file. This does not apply if
  the flag `--dryrun` is passed as well.

  **Example:**
  ```bash
  $ blacksmith run query \
    --integration warehouse \
    --file "./queries/demo.sql" \
    --json
  ```

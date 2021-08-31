---
title: blacksmith run operation
enterprise: false
---

# `blacksmith run operation`

This command runs an operation on top of a SQL database.

**Example:**
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file "./operations/demo.sql" \
  --data "./data/somedata.json" \
  --dryrun
```

## Required flags

- `--integration [integration]`: Integration to run the operation against.

  **Aliases:** `-i [integration]`

  **Example:**
  ```bash
  $ blacksmith run operation \
    --integration warehouse \
    --file "./operations/demo.sql"
  ```

- `--file [filename]`: The relative path to the SQL file to compile and execute
  against the database.

  **Aliases:** `-f [filename]`

  **Example:**
  ```bash
  $ blacksmith run operation \
    --integration warehouse \
    --file "./operations/demo.sql"
  ```

## Optional flags

- `--data [filename]`: The relative path to the CSV or JSON file to pass down to
  the SQL template file as data source.

  **Aliases:** `-d [filename]`

  **Example:**
  ```bash
  $ blacksmith run operation \
    --integration warehouse \
    --file "./operations/demo.sql" \
    --data "./data/somedata.json"
  ```

- `--dryrun`: Only compile the SQL file into `<operation>.compiled.sql` at the
  same location of the template file. This prevents the operation to actually run.

  **Aliases:** `-dr`

  **Example:**
  ```bash
  $ blacksmith run operation \
    --integration warehouse \
    --file "./operations/demo.sql" \
    --dryrun
  ```

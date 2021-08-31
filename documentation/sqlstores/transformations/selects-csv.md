---
title: Downloading as CSV file
enterprise: false
---

# Downloading as CSV file

When running a select, you can download the rows returned as a CSV file with the
`csv` flag. It creates or overwrites the file `<query>.csv`. This file is located
at the same path than the SQL one.
```bash
$ blacksmith run select \
  --integration warehouse \
  --file ./warehouse/selects/demo.sql \
  --csv

Compiling & Running queries:

  -> Compiling & Running ./warehouse/selects/demo.sql...
     Writing CSV at ./selects/warehouse/demo.csv...
     Success!
```

The CSV follows the format desired when passing a `data` flag. This makes the CSV
reusable as a data source when running operations!
```csv
id,first_name,last_name,username,email,created_at
1234567890,John,DOE,john-doe,johndoe@example.com,2021-06-02T16:59:30Z
```

---
title: Your first select
enterprise: false
---

# Your first select

Now that the data properly flowed from the trigger to the data warehouse, we are
able to select some data.

## Writing the file

Here we write a very simple select located at `./warehouse/selects/all-users.sql`:
```sql
SELECT * FROM users;
```

## Running the file

Now we run the select and download the result as both CSV and JSON files:
```bash
$ blacksmith run select \
  -i warehouse \
  -f ./warehouse/selects/all-users.sql \
  --csv --json

Compiling & Running selects:

  -> Compiling & Running ./warehouse/selects/all-users.sql...
     Writing JSON at ./warehouse/selects/all-users.json...
     Writing CSV at ./warehouse/selects/all-users.csv...
     Success!
```

## Versioning results

By default `*.compiled.sql`, `*.csv`, and `*.json` files are versioned by Git.
If you wish to ignore those files, you need to add them in the `.gitignore`.
If those files are in a directory named `warehouse` like in the guides, the
following lines shall be added:
```
warehouse/**/*.compiled.sql
warehouse/**/*.csv
warehouse/**/*.json
```

---
title: Downloading as JSON file
enterprise: false
---

# Downloading as JSON file

When running a select, you can download the rows returned as a JSON file with the
`json` flag. It creates or overwrites the file `<query>.json`. This file is located
at the same path than the SQL one.
```bash
$ blacksmith run select \
  --integration warehouse \
  --file ./warehouse/selects/demo.sql \
  --json

Compiling & Running queries:

  -> Compiling & Running ./warehouse/selects/demo.sql...
     Writing JSON at ./selects/warehouse/demo.json...
     Success!
```

The rows are not exported as a top-level array but inside a `rows` key alongside
the `count` of rows returned. This makes the JSON reusable as a data source when
running operations!
```json
{
  "count": 12,
  "rows": [
    {
      "id": "1234567890",
      "first_name": "John",
      "last_name": "DOE",
      "username": "john-doe",
      "email": "johndoe@example.com",
      "created_at": "2021-06-02T16:59:30Z",
    },

    [...]

  ]
}
```

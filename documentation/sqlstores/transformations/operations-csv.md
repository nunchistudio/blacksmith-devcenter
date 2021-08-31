---
title: Passing data from CSV file
enterprise: false
---

# Passing data from CSV file

It's possible to pass a CSV file as a data source when running an operation.

The CSV must respect a specific format:
- Cells must be comma-separated.
- The first line must be the header one. Each cell of this line represents a key
  which will be used to reference the value of the cell for a line.

With this in mind, a valid CSV shall look like this:
```csv
id,first_name,last_name,username,email,created_at
1234567890,John,DOE,john-doe,johndoe@example.com,2021-06-02T16:59:30Z
```

Every lines but the header one are accessible under the `rows` key. The JSON
representation of this CSV might help you understand how the CSV is then exposed:
```json
{
  "rows": [
    {
      "id": "1234567890",
      "first_name": "John",
      "last_name": "Doe",
      "username": "johndoe",
      "email": "johndoe@example.com",
      "created_at": "2021-06-02T16:59:30Z"
    }
  ]
}
```

In a SQL file, you can then loop over each row using the `for` tag, as shown in
this operation:
```sql
{% for row in rows %}
  INSERT INTO users (id, first_name, last_name, username, email)
    VALUES (
      {{ row.id }},
      '{{ row.first_name | capfirst }}',
      '{{ row.last_name | upper }}',
      '{{ row.username }}',
      '{{ row.email | lower }}'
    );
{% endfor %}
```

Using the `run operation` command, you are able to compile the SQL operation and
pass the CSV file as data source:
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file ./warehouse/operations/demo.sql \
  --data ./warehouse/operations/demo.csv \
  --dry-run

Compiling queries:

  -> Compiling ./warehouse/operations/demo.sql...
     Success!
```

After making sure the output SQL is correct, you can then run the compiled query:
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file ./warehouse/operations/demo.sql \
  --data ./warehouse/operations/demo.csv

Compiling & Running queries:

  -> Compiling & Running ./warehouse/operations/demo.sql...
     Success!
```

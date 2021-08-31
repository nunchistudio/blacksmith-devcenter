---
title: Passing data from JSON file
enterprise: false
---

# Passing data from JSON file

It's possible to pass a JSON file as a data source when running an operation.

The JSON must be have valid map / object at the top level, and not an array.
Therefore, the following example does not work:
```json
[
  {
    "id": "1234567890",
    "first_name": "John",
    "last_name": "DOE",
    "username": "johndoe",
    "email": "johndoe@example.com",
    "created_at": "2021-06-02T16:59:30Z"
  }
]
```

But this one does:
```json
{
  "users": [
    {
      "id": "1234567890",
      "first_name": "John",
      "last_name": "DOE",
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
{% for user in users %}
  INSERT INTO users (id, first_name, last_name, username, email)
    VALUES (
      {{ user.id }},
      '{{ user.first_name | capfirst }}',
      '{{ user.last_name | upper }}',
      '{{ user.username }}',
      '{{ user.email | lower }}'
    );
{% endfor %}
```

Using the `run operation` command, you are able to compile the SQL operation and
pass the JSON file as data source:
```bash
$ blacksmith run operation \
  --integration warehouse \
  --file ./warehouse/operations/demo.sql \
  --data ./warehouse/operations/demo.json \
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
  --data ./warehouse/operations/demo.json

Compiling & Running queries:

  -> Compiling & Running ./warehouse/operations/demo.sql...
     Success!
```

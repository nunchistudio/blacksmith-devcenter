---

gateway:
  values:
    name: "my-sql-store"

  schema:
    - key: "file"
      type: "string"
      example: "./queries/insert-user.sql"
      description: |
        Relative path to the SQL query to compile and execute. Only one of `file`
        and `inline` must be set.

    - key: "inline"
      type: "string"
      description: |
        The SQL query to compile and execute. Only one of `file` and `inline`
        must be set.

---

### Transformation & Load to a SQL database

SQL queries can leverage the [SQL template syntax](/blacksmith/sqltemplate), a
Python / Django-syntax like templating-language.

We'll assume the content of the `insert-user.sql` is as follow (formatted for
better responsive readability):
```sql
INSERT INTO transactions (
  id,
  user_id,
  subscription_id,
  sku, quantity
)
  VALUES (
    '{% uuid %}', -- Generated UUID
    '{{ user_id }}', -- The user ID
    '{{ subscription_id }}', -- The subscription ID
    '{{ sku }}', {{ quantity }}
  );
```

A SQL query can be passed directly with the `inline` key instead of the `file`
one.

Given the `body` example defined above, the `mapping` defined in the example on
the *code* section, and the content of the `file` SQL query, the compiled SQL query
would be:
```sql
INSERT INTO transactions (
  id,
  user_id,
  subscription_id,
  sku, quantity
)
  VALUES (
    '4c9b6622-ba58-482e-ae44-44be78b93197', -- Generated UUID
    '4d6c34df-250e-4fb5-bfb2-27e8d4e9becf', -- The user ID
    '206b0e36-0d24-43f7-9e9c-c1fdf2cd4780', -- The subscription ID
    'BLACKSMITH_EE', 1.0
  );
```

The SQL query is automatically wrapped inside a transaction ensuring full success
or failure.

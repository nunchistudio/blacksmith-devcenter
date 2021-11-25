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
        and `query` must be set.

    - key: "query"
      type: "string"
      description: |
        The SQL query to compile and execute. Only one of `file` and `query`
        must be set.

---

### Load to a SQL database

When **L**oading data to a SQL database, the JSON returned by the `transformation`
is used ad data source for templating the SQL query. It adds a convenient way to
generate SQL dynamically with contextual data and returning the compiled SQL file.

We'll assume the content of the `./queries/insert-user.sql` defined in `config`
is as follow (formatted for better responsive readability):
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

A SQL query can be passed directly with the `query` key instead of the `file`
one.

Given the `body` example defined above, the `transformation` defined in the example
on the *code* section, and the content of the `file` SQL query, the compiled SQL
query would be:
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

The SQL query is automatically wrapped inside a transaction ensuring full
`success` or `failure`.

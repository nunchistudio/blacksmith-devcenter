---
title: Transformation syntax
enterprise: false
---

# Transformation syntax

Blacksmith exposes a Python / Django-like syntax at two different layers in the
data lifecycle.

Firstly, when working inside the `transformation` objects of the gateway. This
adds a convenient way to **T**ransform data from triggers to integrations by
simply using a key / value mapping. When **L**oading data to a blob store, NoSQL
database, topic, and HTTP API, the JSON returned by the `transformation` is the
one actually **L**oaded into the integration:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        mode: "subscription"
        # ...
        integrations:
          - name: "my-nosql-store"
            transformation:
              users: "{% query 'body.friends.#(last=Murphy)#' %}"
```

Secondly, when working within SQL files: **L**oads, *operations*, and *selects*.
This does not apply for migrations because they must be predictable in order to
be reliable. When **L**oading data to a SQL database, the JSON returned by the
`transformation` adds a convenient way to generate SQL dynamically with contextual
data and returning the compiled SQL file:
```sql
{% if order %}
  INSERT INTO orders (amount, user_id) VALUES
    ({{ order.amount }}, '{{ user.id }}');
{% endif %}
```

The **T**ransformation syntax involves four constructs: **variables**, **tags**,
**filters**, and **comments**.

## Variables

Variables are surrounded by `{{` and `}}` like this:
```sql
INSERT INTO orders (amount, user_id) VALUES
  ({{ order.amount }}, '{{ user.id }}');
```

When working in the `transformation` object, these variables are the ones returned
by the trigger when **E**xtracting data from the gateway.

When working in SQL files, these variables are the ones defined previously in the
`transformation` object. When running operations from the CLI, variables are the
ones passed [from a CSV](/blacksmith/sqlstores/transformations/operations-csv) or
[from a JSON](/blacksmith/sqlstores/transformations/operations-json) file.

## Tags & Queries

Tags provide arbitrary logic in the rendering process. Tags are surrounded by
`{%` and `%}` like this:
```sql
{% if order %}
  INSERT INTO orders (amount, user_id) VALUES
    ({{ order.amount }}, '{{ user.id }}');
{% endif %}
```

Queries (defined by the tag `query`) are a particular kind of tags. They allow to
retrieve a subset of data within a single line of configuration. They can be used
for filtering, mapping, grouping, etc. In some cases `query` tags may overlap
features offered by others. While the others are mostly suited for dynamically
*templating* SQL files, `query` tags are best suited inside `transformation`
objects between triggers and integrations:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        mode: "subscription"
        # ...
        integrations:
          - name: "my-nosql-store"
            transformation:
              users: "{% query 'body.friends.#(last=Murphy)#' %}"
```

Then the document put in the NoSQL store would have a single key `users` with the
result of the query `body.friends.#(last='Murphy')#` as value, which given the
example in the appropriate section, is:
```json
{
  "users": [
    {
      "first": "Dale",
      "last": "Murphy",
      "age": 44,
      "nets": ["ig", "fb", "tw"]
    },
    {
      "first": "Jane",
      "last": "Murphy",
      "age": 47,
      "nets": ["ig", "tw"]
    }
  ]
}
```

## Modifiers

Modifiers transform the values of variables with tag arguments. They look like
this:
```sql
INSERT INTO orders (amount, user_id) VALUES
  ({{ order.amount|floatformat:2 }}, '{{ user.id }}');
```

## Comments

As the name suggests, comments lets you comment your template and are not compiled
in the result. They look like this:
```django
{# This won't be compiled #}
```

---
title: Unique IDs
enterprise: false
---

# Unique IDs

## `ksuid`

Generates a new KSUID.

```sql
INSERT INTO orders (id) VALUES
  ('{% ksuid %}');
```

## `uuid`

Generates a new UUID (v4).

```sql
INSERT INTO orders (id) VALUES
  ('{% uuid %}');
```

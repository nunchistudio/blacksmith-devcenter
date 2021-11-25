---
title: Conditions & Wildcards
enterprise: false
---

# Conditions & Wildcards

The examples in this document share the same **E**xtraction result of a trigger
of mode `subscription`:
```json
{
  "status": "success",
  "body": {
    "name": {
      "first": "Tom",
      "last": "Anderson"
    },
    "age": 37,
    "children": [
      "Sara",
      "Alex",
      "Jack"
    ],
    "friends": [
      {
        "first": "Dale",
        "last": "Murphy",
        "age": 44,
        "nets": ["ig", "fb", "tw"]
      },
      {
        "first": "Roger",
        "last": "Craig",
        "age": 68,
        "nets": ["fb", "tw"]
      },
      {
        "first": "Jane",
        "last": "Murphy",
        "age": 47,
        "nets": ["ig", "tw"]
      }
    ]
  }
}
```

## Conditions

In addition to [the common Object & Arrays queries](/blacksmith/transformation/queries/lists)
you can also query an array for the first match by using `#(...)`, or find all
matches with `#(...)#`. Queries support the `==`, `!=`, `<`, `<=`, `>`, `>=`
comparison operators, and the simple pattern matching `%` (like) and `!%` (not
like) operators:
```yml
transformation:
  over_45: "{% query 'body.friends.#(age>45)#' %}"
```

Which outputs:
```json
{
  "over_45": [
    {
      "first": "Roger",
      "last": "Craig",
      "age": 68,
      "nets": ["fb", "tw"]
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

## Wildcards

A key may contain the special wildcard characters `*` and `?`. The `*` will match
on any zero+ characters, and `?` matches on any one character:
```yml
transformation:
  first_child: "{% query 'body.child*.0' %}"
```

Which outputs:
```json
{
  "first_child": "Sara"
}
```

Wildcards can be used inside conditions as well:
```yml
transformation:
  match: "{% query 'body.friends.#(first%D*).last' %}"
```

Which outputs:
```json
{
  "match": "Murphy"
}
```

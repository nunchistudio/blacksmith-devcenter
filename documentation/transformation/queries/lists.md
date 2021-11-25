---
title: Objects & Arrays
enterprise: false
---

# Objects & Arrays

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

A query is intended to be easily expressed as a series of components seperated
by a `.` character.

## Objects

Retrieving the value of a key inside an object can be defined using the desired
key to retrieve, like this:
```yml
transformation:
  last_name: "{% query 'body.name.last' %}"
```

Which outputs:
```json
{
  "last_name": "Anderson"
}
```

## Arrays

### Specific index

Retrieving the value of an index inside an array can be defined using the desired
index to retrieve, like this:
```yml
transformation:
  friend_index_1: "{% query 'body.friends.1' %}"
```

Which outputs:
```json
{
  "friend_index_1": {
    "first": "Roger",
    "last": "Craig",
    "age": 68,
    "nets": ["fb", "tw"]
  }
}
```

If the value of the index is an object, you can deeply chain `.` to get a specific
element:
```yml
transformation:
  friend_firstname_1: "{% query 'body.friends.1.first' %}"
```

Which outputs:
```json
{
  "friend_firstname_1": "Roger"
}
```

### Digging into arrays

The `#` character allows for digging into arrays. You can either use `#` by itself
or followed by the path of a key to retrieve in case the values are objects:
```yml
transformation:
  length: "{% query 'body.friends.#' %}"
  ages: "{% query 'body.friends.#.age' %}"
```

Which outputs:
```json
{
  "length": 3,
  "ages": [44, 68, 47]
}
```

Digging into arrays can be leveraged in tandem with [conditions and
wildcards](/blacksmith/transformation/queries/conditions).

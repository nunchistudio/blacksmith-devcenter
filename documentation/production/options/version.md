---
title: Explicit Blacksmith version
enterprise: false
---

# Explicit Blacksmith version

Blacksmith follows the [Semantic Versioning](https://semver.org/) specification
for release cycle.

To ensure all your environments and engineers use the same Blacksmith version,
you can explicitly set a `version` constraint in the configuration file at
`BLACKSMITH_DIR/services.BLACKSMITH_EXT`:
```yml
version: ">= 1.2.x"

server:
  # ...
```

## Locked version

We strongly advise to set the `version` to a locked version, such as:
```yml
version: "1.2.1"

server:
  # ...
```

This way, if someone in your teams or a node in one of your environments tries
to run Blacksmith with a different version than the exact one specified, an error
will be prompted and Blacksmith will not run:
```bash
$ blacksmith start server

An error occured:

  - Services: The running Blacksmith version (1.0.1) does not meet the
    desired constraint (1.2.1).
```

By locking to a specific version, you ensure your data engineering solution has
the same behavior regardless the environment it's running on.

## Use with comparisons

If you wish to be more flexible, here are detailed comparisons about how semver
constraints can be applied.

### Basic comparisons

There are two elements to the comparisons. First, a comparison string is a list
of space or comma separated AND comparisons. These are then separated by `||` (OR)
comparisons. For example, `>= 1.2 < 3.0.0 || >= 4.2.3` is looking for a comparison
that's greater than or equal to `1.2` and less than `3.0.0` or is greater than or
equal to `4.2.3`.

The basic comparisons are:
- `=`: equal (aliased to no operator)
- `!=`: not equal
- `>`: greater than
- `<`: less than
- `>=`: greater than or equal to
- `<=`: less than or equal to

### Hyphen range comparisons

There are multiple methods to handle ranges and the first is hyphens ranges.
These look like:
- `1.2 - 1.4.5` which is equivalent to `>= 1.2 <= 1.4.5`
- `2.3.4 - 4.5` which is equivalent to `>= 2.3.4 <= 4.5`

### Wildcards in comparisons

The `x`, `X`, and `*` characters can be used as a wildcard character. This works
for all comparison operators. When used on the `=` operator it falls back to the
patch level comparison (see tilde below). For example:
- `1.2.x` is equivalent to `>= 1.2.0, < 1.3.0`
- `>= 1.2.x` is equivalent to `>= 1.2.0`
- `<= 2.x` is equivalent to `< 3`
- `*` is equivalent to `>= 0.0.0`

### Tilde range comparisons (patch)

The tilde (`~`) comparison operator is for patch level ranges when a minor version
is specified and major level changes when the minor number is missing. For example:
- `~1.2.3` is equivalent to `>= 1.2.3, < 1.3.0`
- `~1` is equivalent to `>= 1, < 2`
- `~2.3` is equivalent to `>= 2.3, < 2.4`
- `~1.2.x` is equivalent to `>= 1.2.0, < 1.3.0`
- `~1.x` is equivalent to `>= 1, < 2`

### Caret range comparisons (major)

The caret (`^`) comparison operator is for major level changes once a stable
(`1.0.0`) release has occurred. Prior to a `1.0.0` release the minor versions acts
as the API stability level. For example:
- `^1.2.3` is equivalent to `>= 1.2.3, < 2.0.0`
- `^1.2.x` is equivalent to `>= 1.2.0, < 2.0.0`
- `^2.3` is equivalent to `>= 2.3, < 3`
- `^2.x` is equivalent to `>= 2.0.0, < 3`
- `^0.2.3` is equivalent to `>=0.2.3 <0.3.0`
- `^0.2` is equivalent to `>=0.2.0 <0.3.0`
- `^0.0.3` is equivalent to `>=0.0.3 <0.0.4`
- `^0.0` is equivalent to `>=0.0.0 <0.1.0`
- `^0` is equivalent to `>=0.0.0 <1.0.0`

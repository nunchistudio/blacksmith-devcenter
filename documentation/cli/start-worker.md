---
title: blacksmith start worker
enterprise: false
---

# `blacksmith start worker`

This command starts a Blacksmith worker, given the config found at the
`BLACKSMITH_DIR`.

**Example:**
```bash
$ blacksmith start worker loader
```

## Required arguments

This command requires one argument, which is the worker's name to start. It must
be one of `loader` or `operator`.

**Example:**
```bash
$ blacksmith start worker loader
```

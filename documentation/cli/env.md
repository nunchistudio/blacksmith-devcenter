---
title: blacksmith env
enterprise: false
---

# `blacksmith env`

This command outputs the environment variables Blacksmith uses for the working
directory. They are automatically loaded from `.env` files if applicable.

**Example:**
```bash
$ blacksmith env

Blacksmith environment variables:
  - BLACKSMITH_DIR: blacksmith
  - BLACKSMITH_ENV: development
  - BLACKSMITH_EXT: yml
  - BLACKSMITH_NAMESPACE: default
  - BLACKSMITH_SERVER_URL: localhost:7200
```

Note that the database URLs are not outputted for security reasons. Depending on
your environment, the history might be logged / registered.

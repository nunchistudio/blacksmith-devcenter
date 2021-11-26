---
title: Running the server
enterprise: false
---

# Running the server

As detailed in the "[How it works](/blacksmith/start/onboarding/how)", the server
is the orchestration service. The server itself does not execute application code,
but instead tracks the state of it using queues, timers, and a database.

It is the most important piece of the architecture. Without it, workers can not
operate, and therefore clients can not interact with integrations. 

## Environment

In addition to `BLACKSMITH_DIR`, `BLACKSMITH_ENV`, and `BLACKSMITH_EXT`, the server
relies on the following environment variables to properly work:
```bash
BLACKSMITH_STORE_URL=postgres://user:password@host:5401/blacksmith_store
BLACKSMITH_VISIBILITY_URL=postgres://user:password@host:5402/blacksmith_visibility
```

They are automatically added in `.env` files when generating an application.

If you need to verify the Blacksmith environment variables, you can run:
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

## Starting the server

You can run the server with:
```bash
$ blacksmith start server
```

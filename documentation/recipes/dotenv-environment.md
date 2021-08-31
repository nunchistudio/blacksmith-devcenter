---

---

While the `.env` shall contain variables applicable to all environments, the one
sufixed by an environment's name shall only contain the variables applicable to
the current environment.

If you wish to know the `BLACKSMITH_*` environment variables that will be applied
you can run:
```bash
$ blacksmith env

Blacksmith environment variables:
  - BLACKSMITH_DIR: blacksmith
  - BLACKSMITH_ENV: development
  - BLACKSMITH_EXT: .yml
  - BLACKSMITH_NAMESPACE: default
  - BLACKSMITH_SERVER_URL: localhost:7200
```

Note that the database URLs are not outputted for security reasons. Depending on
your environment, the history might be logged / registered.

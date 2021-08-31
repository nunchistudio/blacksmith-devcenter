---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "http://<user>@<host>:<port>?catalog=<catalog>&schema=<schema>"
      description: |
        The connection string to use to connect to Trino.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

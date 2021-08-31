---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "tcp://<host>:<port>"
      description: |
        The connection string to use to connect to ClickHouse.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

Notes:
- The ClickHouse driver uses the native TCP interface.

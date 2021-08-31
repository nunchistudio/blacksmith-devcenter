---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "<user>:<password>@(tcp:<host>:<port>)/<db>"
      description: |
        The connection string to use to connect to Vitess.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

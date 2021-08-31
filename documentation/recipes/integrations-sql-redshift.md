---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "postgres://<user>:<password>@<host>:<port>"
      description: |
        The connection string to use to connect to AWS Redshift.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

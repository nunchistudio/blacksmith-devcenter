---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "postgres://<user>:<password>@<host>:<port>"
      description: |
        The connection string to use to connect to YugabyteDB.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

Open the .env files to see how the database credentials are set in the application.

The YugabyteDB driver uses the PostgreSQL-compatible YSQL API.

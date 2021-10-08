---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "<user>:<password>@<organization>-<account>/<db>"
      description: |
        The connection string to use to connect to Snowflake.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

Open the .env files to see how the database credentials are set in the application.

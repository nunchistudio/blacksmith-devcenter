---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      example: "vertica://<user>:<password>@<host>:<port>/<database>?<query>"
      description: |
        The connection string to use to connect to Vertica.

integrations:
  values:
    connection: "ANY_ENV_VAR"

---

Open the .env files to see how the database credentials are set in the application.

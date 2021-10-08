---

dotenvdotenv:
  schema:
    - key: "MONGO_SERVER_URL"
      type: "string"
      example: "mongodb://user:password@host:27017/database"
      required: true
      description: |
        The MongoDB connection string.

integrations:
  values:
    connection: "<db>/<collection>"
    params:
      id_field:
        - "<field>"

---

Open the .env files to see how MongoDB credentials are set in the application.

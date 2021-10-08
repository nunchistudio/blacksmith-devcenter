---

dotenvdotenv:
  schema:
    - key: "SERVICEBUS_CONNECTION_STRING"
      type: "string"
      example: "Endpoint=sb://..."
      required: true
      description: |
        The Azure Service Bus connection string for pub / sub.

integrations:
  values:
    connection: "<topic>"

---

Open the .env files to see how Azure credentials are set in the application.

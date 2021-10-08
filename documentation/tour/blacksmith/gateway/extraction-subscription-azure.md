---

dotenvdotenv:
  schema:
    - key: "SERVICEBUS_CONNECTION_STRING"
      type: "string"
      example: "Endpoint=sb://..."
      required: true
      description: |
        The Azure Service Bus connection string for pub / sub.

gateway:
  trigger:
    values:
      topic: "<topic>"
      queue: "<subscription>"

---

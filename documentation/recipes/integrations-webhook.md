---

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-webhook"
      required: true
      description: |
        The name of the integration to register.

    - key: "base_url"
      type: "string"
      example: "http://example.com"
      required: true
      description: |
        HTTP base URL without the trailing slash that will prefix all the
        HTTP endpoints registered in this integration.

---

Once registered, an integration of type `webhook` allows to interact with a HTTP
API for **L**oading data into a web service.

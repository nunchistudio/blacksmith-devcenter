---

integrations:
  schema:
    - key: "name"
      type: "string"
      example: "my-topic"
      required: true
      description: |
        The name of the integration to register.

    - key: "driver"
      type: "string"
      required: true
      description: |
        The driver to leverage for publishing messages.
    
    - key: "connection"
      type: "string"
      required: true
      description: |
        The driver-specific connection string.

    - key: "params"
      type: "map[string][]string"
      description: |
        Driver-specific params to pass to the connection string.

---

Once registered, an integration of type `topic` allows to interact with a message
broker for **L**oading (a.k.a. *publishing*) data into a topic.

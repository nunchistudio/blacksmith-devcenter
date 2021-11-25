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
      type: "url.Values"
      description: |
        Driver-specific params to pass to the connection string.

---

### Working with topics

Once registered, an integration of type `topic` allows to interact with a message
broker for **L**oading (a.k.a. *publishing*) data into a topic. Within a trigger
in the gateway:
```yml
sources:
  - name: "my-source"
    # ...
    triggers:
      - name: "my-trigger"
        # ...
        integrations:
          - name: "my-topic"
            transformation:
              # ...
            config:
              # ...
```

---

gateway:
  source:
    schema:
      - key: "name"
        type: "string"
        example: "my-source"
        required: true
        description: |
          The name for the source that will be used across services.

      - key: "driver"
        type: "string"
        required: true
        description: |
          The driver to use for Extracting messages from a subscription.

      - key: "policies"
        type: "object"
        items:
          - key: "extraction"
            type: "object"
            items:
              - key: "timeout"
                type: "integer"
        example:
          extraction:
            timeout: 15
        required: true
        description: |
          The policy to apply by default for all the triggers registered in this
          source.

  trigger:
    schema:
      - key: "name"
        type: "string"
        example: "my-trigger"
        required: true
        description: |
          The name for the trigger that will be used across services.

      - key: "topic"
        type: "string"

      - key: "queue"
        type: "string"

    transformation:
      values:
        user_id: "body.data.user.id"
        subscription_id: "body.data.subscriptions[0].id"
        sku: "body.data.subscriptions[0].sku"
        quantity: "body.data.subscriptions[0].quantity"

---

### Extraction from subscription

A trigger of mode subscription (`subscription`) allows to **E**xtract messages
received in a subscription of a message broker. It is done by subscribing to a
*queue* using the details passed in the source's `defaults.subscription` config
and the `config.subscription` of the said trigger.

Once **E**xtracted (in other words, once a message was published and received into
the defined trigger), the trigger returns a JSON object with:
- `status`: The status of the **E**xtraction. It is one of `success`, `failure`.
- `meta`: The JSON metadata of the message received by the broker, if any.
- `body`: The JSON body of the message received by the broker.

Knowing this, a trigger of mode `subscription` shall return an object like this:
```json
{
  "status": "success",
  "meta": {
    "language": "en",
    "source": "js-sdk"
  },
  "body": {
    "user": {
      "id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
      "first_name": "John",
      "last_name": "Doe",
      "username": "johndoe",
      "address": {
        "city": "Austin"
      }
    },
    "subscriptions": [
      {
        "id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
        "name": "Enterprise Edition",
        "sku": "BLACKSMITH_EE",
        "quantity": 1.0
      }
    ]
  }
}
```

This object is then available in the `transformation` object for each integration
configured within the trigger, as described below.

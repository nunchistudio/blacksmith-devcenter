---

dotenvdotenv:
  schema:
    - key: "ANY_ENV_VAR"
      type: "string"
      required: true
      description: |
        The connection string to use to connect to the SQL database.

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
          The driver to use for Extracting messages from a Change Data Capture
          of a SQL database.

      - key: "connection"
        type: "string"
        example: "ANY_ENV_VAR"
        required: true
        description: |
          The connection string to use to connect to the SQL store.

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

      - key: "channel"
        type: "string"
        required: true
        description: |
          The channel to subscribe to for receiving notifications.

    mapping:
      values:
        user_id: "new.user_id"
        subscription_id: "new.subscription_id"
        sku: "new.subscription_sku"
        quantity: "new.subscription_quantity"

---

A trigger of mode SQL Change Data Capture (`sql_cdc`) **E**xtracts data from an
event of a SQL database in realtime. It is done by subscribing to a *channel*
using the details passed in the source's `defaults.sql_cdc` config and the
`config.sql_cdc` of the said trigger.

Once **E**xtracted (in other words, once a row is `INSERT`ed, `UPDATE`d, or
`DELETE`d), the trigger exposes:
- `status`: The status of the Extraction process. It is one of `succeeded`,
  `failed`.
- `table`: The table's name where the changes occured.
- `operation`: The operation's type captured. It is one of `INSERT`, `UPDATE`,
  `DELETE`.
- `old`: The old row formatted in JSON. It will be `null` on `INSERT` events.
- `new`: The new row formatted in JSON. Il will be `null` on `DELETE` events.
  Example:
  ```json
  {
    "user_id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
    "subscription_id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
    "subscription_sku": "BLACKSMITH_EE",
    "subscription_quantity": 1.0,
  }
  ```

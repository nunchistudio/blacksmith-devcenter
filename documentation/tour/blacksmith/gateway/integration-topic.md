---

gateway:
  values:
    name: "my-topic"

  schema:
    - key: "meta"
      type: "map[string]string"
      example:
        source: "sdk-js"
      description: |
        Metadata object to apply to the message published.

---

### Transformation & Load to a topic

Given the example defined above and the `transformation` defined in the example
on the *code* section, the JSON message published into the topic would be:
```json
{
  "user_id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
  "subscription_id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
  "sku": "BLACKSMITH_EE",
  "quantity": 1.0
}
```

And the metadata associated to the message would be:
```json
{
  "source": "sdk-js"
}
```

---

gateway:
  values:
    name: "my-nosql-store"

---

### Transformation & Load to a NoSQL database

Given the example defined above and the `mapping` defined in the example on the
*code* section, the JSON document put into the NoSQL store would be:
```json
{
  "user_id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
  "subscription_id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
  "sku": "BLACKSMITH_EE",
  "quantity": 1.0
}
```

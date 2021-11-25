---

---

### Transformation syntax

In the `transformation` object of the trigger, each key has access to the
[Transformation syntax](/blackmsith/transformation). This means that values can
be dynamically computed from the JSON returned by the **E**xtraction as explained
above.

Given the JSON returned by the **E**xtraction and the `transformation` object
defined, the JSON object returned by the **T**ransformation would be:
```json
{
  "user_id": "4d6c34df-250e-4fb5-bfb2-27e8d4e9becf",
  "subscription_id": "206b0e36-0d24-43f7-9e9c-c1fdf2cd4780",
  "sku": "BLACKSMITH_EE",
  "quantity": 1.0
}
```

---
title: Well-defined models
enterprise: false
---

# Well-defined models

Data validation plays an important role for ensuring the best data quality across
teams and systems. While writing models for validating the data is optional in
Blacksmith, we highly recommend to do so since data reliability and quality from
end-to-end is critical for an organisation.

In the ETL pipeline, validating data against a model ensures data quality both at
the trigger level right after **E**xtracting the data, and at the integration level
right before **L**oading the data. In other words, you can set validations *pre*
and *post* **T**ransformation. Without validation, you may try to **L**oad bad
data against an integration. Depending on the behavior of the said integration,
it might break or accept the bad data. Either way, data is broken because it's
either missing or not valid.

Models can be set with the `model` key, both within the trigger and integration
configuration:
```yml
sources:
  - name: "api"
    # ...
    triggers:
      - name: "new_user"
        # ...
        model: "./models/users/extraction.json"
        integrations:
          - name: "warehouse"
            # ...
            model: "./models/users/load-snowflake.json"
```

Blacksmith doesn't enforce how models are organised in your application. It's up
to data teams to adjust in the way they consider the most appropriate to fit their
needs.

---
title: Your first event
enterprise: false
---

# Your first event

Since the SQL integration `warehouse` now has the table `users`, it is ready to
welcome some data. Let's `INSERT` our first user!

The trigger `new_user` of the source `api` exposes a HTTP route for incoming
webhooks. We can therefore make a HTTP request with the appropriate data.

Using [`curl`](https://curl.se/):
```bash
$ curl --request POST \
  --url http://localhost:9090/api/user \
  --header 'Content-Type: application/json' \
  --data '{
    "user": {
      "username": "johndoe"
    }
  }'
```

Using [Insomnia](https://insomnia.rest/):

![Your first event](/images/blacksmith/insomnia.png)

As a best practice, we should add data validations using *models*, both pre and
post **T**ransformation.

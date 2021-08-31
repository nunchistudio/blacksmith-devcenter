---
title: Leveraging the Enterprise Edition
enterprise: true
---

# Leveraging the Enterprise Edition

For leveraging Blacksmith Enterprise Edition you must pass your subscription
details to Blacksmith. This is done by setting the environment variables
`BLACKSMITH_LICENSE_KEY` and `BLACKSMITH_LICENSE_TOKEN`. If you leverage `.env`
files, you should add:
```bash
BLACKSMITH_LICENSE_KEY=<key>
BLACKSMITH_LICENSE_TOKEN=<token>
```

Blacksmith will verify your credentials when requesting a resource only available
on the Enterprise Edition. Is does so by making a request to the Nunchi Checkpoint
API. If an error occured or the subscription returned is not valid, Blacksmith
will stop the desired task.

To avoid any network error, make sure you can make a request against the following
URL from your different environments:
```bash
$ curl --request GET --url 'https://nunchi.studio/api/checkpoint'
```

Also, every 4 hours the Blacksmith server will make the same request as detailed
before. If the subscription is not valid anymore, Blacksmith will prompt a warning
until the subscription is valid again, for up to 72 hours. After that, the
running server will be interrupted.

You can update your subscription, billing information, and payment details by
running:
```bash
$ blacksmith login
```

It will prompt a link to open a new session within the Nunchi Customer Portal,
powered by [Stripe](https://stripe.com/) for simplified billing:

![Nunchi Customer Portal](/images/blacksmith/portal.png)

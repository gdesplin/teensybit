# README

This is an app to helper daycare providers manage their daycares.

Notes:
* Guardian & parent are used interchangbly, parent is a reserved class name, so we can't use it in our user:kind enum declaration

Testing stripe locally:
* Install Stripe CLI ```brew install stripe/stripe-cli/stripe```
* Use terminal to sign into stripe ```stripe login```
* ```stripe listen --forward-to localhost:3000/stripe_webhooks```
* make sure webhook signing secret is correct in .env

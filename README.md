# README

This is an app to helper daycare providers manage their daycares.

Notes:
* Guardian & parent are used interchangbly, parent is a reserved class name, so we can't use it in our user:kind enum declaration

Testing stripe locally:
* Install Stripe CLI ```brew install stripe/stripe-cli/stripe```
* Use terminal to sign into stripe ```stripe login```
* ```stripe listen --forward-to localhost:3000/stripe_webhooks```
* make sure webhook signing secret is correct in .env

Notes Running Locally
* May need to run `./bin/webpack-dev-server` in seperate terminal
* If you get an error like `Error: error:0308010C:digital envelope routines::unsupported` then you may need to run `export NODE_OPTIONS=--openssl-legacy-provider` first.

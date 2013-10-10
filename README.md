# accounts-entry

A meteorite package that relies on Iron Router and gives you sign page login styles.

We wanted something to work with that used [Iron
Router](https://github.com/EventedMind/iron-router), [Bootstrap
3](https://github.com/mangasocial/meteor-bootstrap-3), and didn't require the forcing of the dropdown box that didn't seem to be easily styled. But we love the ease of adding more packages like accounts-facebook or accounts-twitter, so we fully support the oauth packages by adding buttons to let people sign-up/sign-in with those services if you add them.  Right now it also assumes you will be using accounts-password, but we will likely make that optional in the future.

## Getting started

Run:

````
mrt add accounts-ui
mrt add accounts-entry
````

You need to have `accounts-ui` package, as we depend on aspects of it.

## Provided routes

You will get routes for:
````
/sign-in
/sign-out
/sign-up
/forgot-password
````

You can then either add links to those directly, or use the ````{{accountButtons}}```` helper we provide to give you the proper links.

## Setting up oauth/social integrations

Use `accounts-ui` to configure your social/oauth integrations (or manually create records in your database, if you have those skills). We don't have the nice instructions on how to configure the services built into this package.

## Configuration

Since this is a young package, we are maintaining compatibility with accounts-ui (so if in a pinch accounts-entry is broken for you, you could easily switch to accounts-ui).

As such, the `passwordSignunFields` attributes from Accounts.ui.config is read by accounts-entry to determine what fields to show during sign up and sign in.

```
Meteor.startup ->
  Accounts.ui.config(
    passwordSignupFields: 'EMAIL_ONLY'
  )
```

Somewhere in your server code, call `AccountsEntry.config`
with a hash of optional configuration:

```
Meteor.startup ->
  AccountsEntry.config
    logo: 'logo.png'
    signupCode: 's3cr3t'
    privacyUrl: '/privacy-policy'
    termsUrl: '/terms-of-use'
    homeRoute: 'home'
    dashboardRoute: 'dashboard'
    profileRoute: 'profile'
    defaultProfile: 
        someDefault: 'default'
```

The default configuration includes:

````
  wrapLinks: true
  homeRoute: 'home'
  dashboardRoute: 'dashboard'
  defaultProfile: {}
````

You must provide a route for home (used when signing out) and
dashboard (used after signing in).

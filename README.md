# accounts-entry

A meteorite package that relies on Iron Router and gives you sign page login styles.

We wanted something to work with that used [Iron
Router](https://github.com/EventedMind/iron-router), [Bootstrap
3](https://github.com/mangasocial/meteor-bootstrap-3), and didn't require the forcing of the dropdown box that didn't seem to be easily styled. But we love the ease of adding more packages like accounts-facebook or accounts-twitter, so we fully support the oauth packages by adding buttons to let people sign-up/sign-in with those services if you add them.  Right now it also assumes you will be using accounts-password, but we will likely make that optional in the future.

## Getting started

Just run:

````
mrt add accounts-entry
````

After that you will get routes for:
````
/sign-in
/sign-out
/sign-up
/forgot-password
````

You can then either add links to those directly, or use the ````{{accountButtons}}```` helper we provide to give you the proper links.

## Configuration

Somewhere in your client code, set `AccountsEntry.config` equal to a hash of configuration options:

```
{
  logo: 'logo.png',
  privacyUrl: '/privacy-policy',
  termsUrl: '/terms-of-use',
  homeRoute: 'home',
  dashboardRoute: 'dashboard'
}
```

It's OK to leave some config blank, if you don't have a logo, privacy
policy, terms of use for your app.

But you must provide a route for home (used when signing out) and
dashboard (used after signing in).


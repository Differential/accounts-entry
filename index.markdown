---
layout: default
username: BeDifferential
repo: accounts-entry
desc: Meteor sign up and sign in pages.
version: 0.6.1

---

# accounts-entry

accounts-entry is a meteorite package that relies on Iron Router and provides an
alternative interface to accounts-ui, with whole pages for sign up
and sign in.

We wanted something to work with that used [Iron Router](https://github.com/EventedMind/iron-router),
[Bootstrap 3](https://github.com/mangasocial/meteor-bootstrap-3), and didn't require the forcing of
the dropdown box that didn't seem to be easily styled. But we love the ease of adding more packages like `accounts-facebook` or `accounts-twitter`, so we fully support the OAuth packages by adding buttons to let people sign-up/sign-in with those services if you add them.  Right now it also assumes you will be using `accounts-password`, but we will likely make that optional in the future.

Examples of the package in action (check out the sign up or sign in
links):

* [https://carp.io/](https://carp.io/)
* [https://getliquid.io/](https://getliquid.io/)
* [http://support.unpolishedcr.com/](http://support.unpolishedcr.com/)
* Email team@differential.io to add your project to the list.

[Changelog](https://github.com/BeDifferential/accounts-entry/blob/master/CHANGELOG.md)

## Compatibility

accounts-entry is presently compatible with Iron Router 0.6.0 and above. Since meteorite doesn't support semantic version locking, we are currently pegged to 0.6.4 of Iron-router.

## Getting started

Run:

```
mrt add accounts-entry
```

You can install the `accounts-ui` package, as it is still used for oauth setup.

## Provided routes

You will get routes for:

```
/sign-in
/sign-out
/sign-up
/forgot-password
```

{% assign special = '{{accountButtons}}' %}
You can then either add links to those directly, or use the `{{ special }}` helper we provide to give you the proper links.

## Ensuring signed in users for routes

Use `AccountsEntry.signInRequired(this)` to require signed in users for a route. Stick that in your before hook function and it will redirect to sign in and stop any rendering. Accounts Entry also tracks where the user was trying to go and will route them back after sign in.

For example in coffeescript we would use:

````
Route.map () ->
  @route 'createPayment',
    path: '/create/payment'
    before: ->
      AccountsEntry.signInRequired(@)
````

## Setting up password login

Use `mrt add accounts-password` if you want to have email/username login authentication options. This is now optional and will only display if installed. You need to install an oauth option if you choose not to have password logins.

## Setting up oauth/social integrations

Use `accounts-ui` to configure your social/oauth integrations (or manually create records in your database, if you have those skills). We don't have the nice instructions on how to configure the services built into this package.

## Configuration

### Signup codes

We have added support for a signupCode in case you want to have a special code to handout to keep signups as a pace you want. This code is checked if you turn on the client and server side options listed below.

The signup code is only checked for accounts-password logins, so know that oAuth logins will still allow people in.

### On the client (only)

Since this is a young package, we are maintaining compatibility with accounts-ui (so if in a pinch accounts-entry is broken for you, you could easily switch to accounts-ui). We also use the UI for oauth configs from accounts-ui.

{% highlight coffeescript %}
Meteor.startup ->
  AccountsEntry.config
    logo: 'logo.png'
    privacyUrl: '/privacy-policy'
    termsUrl: '/terms-of-use'
    homeRoute: '/'
    dashboardRoute: '/dashboard'
    profileRoute: 'profile'
    passwordSignupFields: 'EMAIL_ONLY'
    showSignupCode: true
{% endhighlight %}

### On the server (only)

Call `AccountsEntry.config` with a hash of optional configuration:

{% highlight coffeescript %}
Meteor.startup ->
  AccountsEntry.config
    signupCode: 's3cr3t'
    defaultProfile:
        someDefault: 'default'
{% endhighlight %}

*Note: don't set a signupCode unless you want to use that feature.*

The default configuration includes:

{% highlight coffeescript %}
  wrapLinks: true
  homeRoute: '/'
  dashboardRoute: '/dashboard'
{% endhighlight %}

You must provide a route for home (used when signing out) and
dashboard (used after signing in).

## Interested in building a quick meteor app that starts with Accounts-Entry?

We've create a [meteor-boilerplate repo](http://github.differential.io/meteor-boilerplate/) that you can clone as a starting point for an app.  It follows all our standards that we use for building apps for our clients.

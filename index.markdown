---
layout: default
username: BeDifferential
repo: accounts-entry
desc: Meteor sign up and sign in pages.

---

# accounts-entry

A meteorite package that relies on Iron Router and provides an
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

accounts-entry is presently compatible with Iron Router 0.5.4 and 0.6.0.

## Getting started

Run:

```
mrt add accounts-ui
mrt add accounts-password
mrt add accounts-entry
```

You need to have `accounts-ui` package, as we depend on aspects of it.

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

## Setting up oauth/social integrations

Use `accounts-ui` to configure your social/oauth integrations (or manually create records in your database, if you have those skills). We don't have the nice instructions on how to configure the services built into this package.

## Configuration

### Signup codes

We have added support for a signupCode in case you want to have a special code to handout to keep signups as a pace you want. This code is checked if you turn on the client and server side options listed below.

The signup code is only checked for accounts-password logins, so know that oAuth logins will still allow people in.

### On the client (only)

Since this is a young package, we are maintaining compatibility with accounts-ui (so if in a pinch accounts-entry is broken for you, you could easily switch to accounts-ui).

As such, the `passwordSignupFields` attributes from Accounts.ui.config is read by accounts-entry to determine what fields to show during sign up and sign in.

{% highlight coffeescript %}
Meteor.startup ->
  Accounts.ui.config
    passwordSignupFields: 'EMAIL_ONLY'

  AccountsEntry.config
    logo: 'logo.png'
    privacyUrl: '/privacy-policy'
    termsUrl: '/terms-of-use'
    homeRoute: '/'
    dashboardRoute: '/dashboard'
    profileRoute: 'profile'
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

*Note: don't set a signupCode unless you want to use that feature*

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

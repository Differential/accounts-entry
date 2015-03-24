[![Stories in Ready](https://badge.waffle.io/Differential/accounts-entry.png?label=ready&title=Ready)](https://waffle.io/Differential/accounts-entry)
# Meteor accounts-entry [![Build Status](https://travis-ci.org/Differential/accounts-entry.png)](https://travis-ci.org/Differential/accounts-entry)

accounts-entry is a meteor package that relies on Iron Router and provides an alternative interface to accounts-ui, with whole pages for sign up and sign in.

## Getting started

Run:

```
meteor add joshowens:accounts-entry
```

You can install the `accounts-ui` package, as it is still used for OAuth setup.


We wanted something to work with that used [Iron Router](https://github.com/EventedMind/iron-router),
[Bootstrap 3](https://github.com/mangasocial/meteor-bootstrap-3), and didn't require the forcing of
the dropdown box that didn't seem to be easily styled. But we love the ease of adding more packages like `accounts-facebook` or `accounts-twitter`, so we fully support the OAuth packages by adding buttons to let people sign-up/sign-in with those services if you add them.  By default, accounts-entry doesn't offer email/password login functionality.  If you `meteor add accounts-password`, accounts-entry will offer your users the option to sign-up/sign-in with a username and password.

![Example](http://github.differential.com/accounts-entry/images/Example.png)

Examples of the package in action (check out the sign up or sign in
links):

* [https://linklyapp.com/](https://linklyapp.com/)
* [https://carp.io/](https://carp.io/)
* [https://getliquid.io/](https://getliquid.io/)
* [http://support.unpolishedcr.com/](http://support.unpolishedcr.com/)
* Submit PR with a description to add your project to the list.

[Changelog](https://github.com/BeDifferential/accounts-entry/blob/master/CHANGELOG.md)

## Compatibility

accounts-entry is presently compatible with Iron Router 1.0.3 and above.

## Provided routes

You will get routes and the necessary templates for:

```
/sign-in
/sign-out
/sign-up
/forgot-password
/verification-pending
```

You can then either add links to those directly, or use the `{{ special }}` helper we provide to give you the apppropriate links for signed-in/signed-out users.  The `{{ special }}` helper will display a sign-out link and the user's email address when they are signed-in.

## Ensuring signed in users for routes

Simply add the following line of code: `AccountsEntry.signInRequired(this);` to require users be signed in for a route and to redirect the user to the included sign-in page and stop any rendering. Accounts-entry also tracks where the user was trying to go and will route them back after sign in.

Here is an Iron-Router route example:

````js
  this.route('userProfile', {
    path: '/profile',
    template: 'profile',
    onBeforeAction: function () {
      AccountsEntry.signInRequired(this);
    }
  });
````

## Setting up password login

Use `mrt add accounts-password` if you want to have email/username login authentication options. This is now optional and will only display if installed. You need to configure an OAuth option if you choose not to have password logins.

## Setting up OAuth/social integrations

Use `accounts-ui` to configure your social/OAuth integrations (or manually create records in your database, if you have those skills). We don't have the nice instructions on how to configure the services built into this package, but if you choose to use <code>{{ loginButtons }}</code> elsewhere in your application (even temporarily), you can configure OAuth logins there.

## Configuration

### Signup codes

We have added support for a signupCode in case you want to have a special code to handout to keep signups at a pace you want. This code is checked if you turn on the client and server side options listed below.

**The signup code is only checked for accounts-password logins, so know that OAuth logins will still allow people in.**

### In CLIENT code only

Since this is a young package, we are maintaining compatibility with accounts-ui (so if in a pinch accounts-entry is broken for you, you could easily switch to accounts-ui). We also use the UI for oauth configs from accounts-ui.

```js
  Meteor.startup(function () {
    AccountsEntry.config({
      logo: 'logo.png'                  // if set displays logo above sign-in options
      privacyUrl: '/privacy-policy'     // if set adds link to privacy policy and 'you agree to ...' on sign-up page
      termsUrl: '/terms-of-use'         // if set adds link to terms  'you agree to ...' on sign-up page
      homeRoute: '/'                    // mandatory - path to redirect to after sign-out
      dashboardRoute: '/dashboard'      // mandatory - path to redirect to after successful sign-in
      profileRoute: 'profile'
      passwordSignupFields: 'EMAIL_ONLY'
      showSignupCode: true
      showOtherLoginServices: true      // Set to false to hide oauth login buttons on the signin/signup pages. Useful if you are using something like accounts-meld or want to oauth for api access
      extraSignUpFields: [{             // Add extra signup fields on the signup page
        field: "name",                           // The database property you want to store the data in
        name: "This Will Be The Initial Value",  // An initial value for the field, if you want one
        label: "Full Name",                      // The html lable for the field
        placeholder: "John Doe",                 // A placeholder for the field
        type: "text",                            // The type of field you want
        required: true                           // Adds html 5 required property if true
       }]
       fluidLayout: false               // Set to true to use bootstrap3 container-fluid and row-fluid classes.
       useContainer: true               // Set to false to use an unstyled "accounts-entry-container" class instead of a bootstrap3 "container" or "container-fluid" class. 
       signInAfterRegistration: true    // Set to false to avoid prevent users being automatically signed up upon sign-up e.g. to wait until their email has been verified. 
       emailVerificationPendingRoute: '/verification-pending' // The route to which users should be directed after sign-up. Only relevant if signInAfterRegistration is false.
       showSpinner: true                // Show the spinner when the client is talking to the server (spin.js)
       spinnerOptions: { color: "#000", top: "80%" } // options as per [spin.js](http://fgnass.github.io/spin.js/)

    });
  });
```

### In SERVER code only

Call `AccountsEntry.config` with a hash of optional configuration:

```js
  Meteor.startup(function () {
    AccountsEntry.config({
      signupCode: 's3cr3t',         // only restricts username+password users, not OAuth
      defaultProfile:
          someDefault: 'default'
    });
  });
```

*Note: only set a signupCode if you want to use that feature.*

The default configuration includes:

```js
  wrapLinks: true                   // wraps accounts-entry links in <li> for bootstrap compatability purposes
  homeRoute: '/'                    // MUST BE SET - redirect to this path after sign-out
  dashboardRoute: '/dashboard'      // MUST BE SET - redirect to this path after sign-in
```

Remember, you must provide a route for home (used when signing out) and
dashboard (used after signing in).

## Interested in building a quick meteor app that starts with Accounts-Entry?

We've created a [meteor-boilerplate repo](http://github.differential.com/meteor-boilerplate/) that you can clone as a starting point for an app.  It follows all our standards that we use for building apps for our clients.

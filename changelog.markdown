---
layout: default
username: BeDifferential
repo: accounts-entry
version: 0.4.2
desc: Meteor sign up and sign in pages.

---
# Changelog

### v0.4.3

* Switch to Font-Awesome 4.0 syntax
* More IronRouter syntax changes
* Fix typo in register handlebars helper
* Return a string instead of a route from the helper

### v0.4.2

* Fixed bug with missing helper (otherServicesLogin) on signup page.

### v0.4.1

* Change version of iron-router we are pulling in, now use 0.6.0

### v0.4.0

* Change configuration to be partially on client, partially on server.
  There were issues with getting the Session set based on a Meteor.call
  with the previous implementation, so most settings are back on the
  client, only signupCode and defaultProfile are set on server now.
* Fixes bug to allow signup without signupCode

### v0.3.1

* Fix various router redirects to use variables set in the config instead of hardcodings [#25](https://github.com/BeDifferential/accounts-entry/issues/25) and [#26](https://github.com/BeDifferential/accounts-entry/issues/26)

### v0.3.0

* Fix client side login to happen after we create the user server side [#24](https://github.com/BeDifferential/accounts-entry/issues/24)
* Fix an issue with event passing and Firefox/IE issues [#23](https://github.com/BeDifferential/accounts-entry/issues/23)
* Optionally protect signup form with a signup code
* Move configuration to server
* Configuration is set by calling a method rather than setting an
  attribute of AccountsEntry object

### v0.2.10

* Add a sign out route via iron router (/sign-out)
* Make signedInAs a global helper instead of just in the accountButtons template

### v0.2.9

* Return a string instead of true for the username on signup

### v0.2.8

* Fix css targetting for signout link changes

### v0.2.7

* Make Sign In header tag consistent with rest of package

### v0.2.6

* Move create account header outside of the if logic so you see the header no matter what your settings.

### v0.2.5

* Removed more differential naming from the package

---
layout: default
username: BeDifferential
repo: accounts-entry
version: 0.3.0
desc: Meteor sign up and sign in pages.

---
# Changelog

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

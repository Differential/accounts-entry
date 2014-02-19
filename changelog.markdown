---
layout: default
username: BeDifferential
repo: accounts-entry
desc: Meteor sign up and sign in pages.
version: 0.6.0

---
# Changelog
### Master

### 0.6.0

* Added first tests using TinyTest
* Switch to using t9n so we get wrapped up translations for Meteor Core accounts-base errors [#86](https://github.com/BeDifferential/accounts-entry/pull/86)
* Track redirects because of signInRequired and redirect back once sign in/sign up is completed [#13](https://github.com/BeDifferential/accounts-entry/issues/13)
* Added signInRequired helper method
* Fixed various langauge issues with translations [6086a1](https://github.com/BeDifferential/accounts-entry/commit/6086a17a3d3fe7fd1d4f2ab71d0ed9553756b1f0)
* Usernames in sign up + sign in should not be case sensitive [#65](https://github.com/BeDifferential/accounts-entry/issues/65)
* Add before hooks to the settings so you can tweak html before each accountButtons link (NEEDS DOCS) [8b9555](https://github.com/BeDifferential/accounts-entry/commit/8b9555ed33827fa16d15191377de5e8256be749e)
* Fix template override to work correctly [#83](https://github.com/BeDifferential/accounts-entry/issues/83)
* Fix redirect happening before login is finished processing [#78](https://github.com/BeDifferential/accounts-entry/pull/78)
* Sign up code was being required by faulty logic, make it optional now. [#69](https://github.com/BeDifferential/accounts-entry/issues/69)
* Add missed translations [cd7192](https://github.com/BeDifferential/accounts-entry/commit/cd719282796e76f1c431e526d650238af6da622d)
* Add german support [#70](https://github.com/BeDifferential/accounts-entry/pull/70)

### 0.5.3

### 0.5.2

### 0.5.1

### 0.5.0

* Use Accounts.createUser call instead of our own [c2b2cf](https://github.com/BeDifferential/accounts-entry/commit/c2b2cfca0be407cb90b8575a9c794549b0c5dbb3)
* Fix calls to use proper settings for logo now [#47](https://github.com/BeDifferential/accounts-entry/issues/47)
* Switch package to use i18n and add english and spanish translations [#46](https://github.com/BeDifferential/accounts-entry/pull/46)
* Allow signupTemplate to be overridden [ad0381d](https://github.com/BeDifferential/accounts-entry/commit/ad0381d3fa80aa2247b9d6200d4489f1fd3430c8)
* Refactor the folder structure of the package [ad0381d](https://github.com/BeDifferential/accounts-entry/commit/ad0381d3fa80aa2247b9d6200d4489f1fd3430c8)
* Add an optional placeholder if email is marked as optional in the config. [#39](https://github.com/BeDifferential/accounts-entry/pull/39)

### v0.4.4

* Switch to our own reset-password setup in IronRouter
* Tweaked wording on forgot password header

### v0.4.3

* Update to IronRouter 0.6.1
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

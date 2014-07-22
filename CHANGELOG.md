---
layout: default
username: Differential
repo: accounts-entry
desc: Meteor sign up and sign in pages.
version: 0.8.0

---
# Changelog

### 0.8.0

* Support email verification sending for accounts-password. Fixes #75. Fixes #190. [8540eb5](http://github.com/Differential/accounts-entry/commit/8540eb5fa5a3fdbdc729f2f74e72c9397e66ce37)
* Hash passwords client-side before they go over the wire. [f53c7c8](http://github.com/Differential/accounts-entry/commit/f53c7c8a5bc3c3589d4b54fac47c50028345e06d)
* added arabic translation [3a2fa7b](http://github.com/Differential/accounts-entry/commit/3a2fa7b4c38cdcf866f403fa45d97743b45412ec)
* added russian translation [4b106e3](http://github.com/Differential/accounts-entry/commit/4b106e3dadcc4638232bcca01d61a2e44ab50346)
* Add a profile helper to accountButtons helper methods [7c41760](http://github.com/Differential/accounts-entry/commit/7c4176085d170f4fb15077f4a73c8d2fdaaecf7b)
* added current route to fromWhere session var [94aafc5](http://github.com/Differential/accounts-entry/commit/94aafc54f7932c29e92b5f3522e97c0346d74731)
* Add profile to server account create user [d78ed24](http://github.com/Differential/accounts-entry/commit/d78ed248fbc6926145cc4d47888edbf3d0ba521c)
* updated buttonText helper [31a5917](http://github.com/Differential/accounts-entry/commit/31a5917278a690f9d21918061a759905d48d7c89)
* redirect user from sign-in if already signed in [8e952fb](http://github.com/Differential/accounts-entry/commit/8e952fb16f5ef8fa031f0bc51103f01f974b2bf5)
* changed social signUp usage [faea789](http://github.com/Differential/accounts-entry/commit/faea7893ae767384351924114112131db700c295)
* updated english language sign-up terms [9b774f1](http://github.com/Differential/accounts-entry/commit/9b774f1e5cafbeb3e33421a4f6bb7743d4735995)
* Add showOtherLoginServices option [a3b61e7](http://github.com/Differential/accounts-entry/commit/a3b61e7900ffb2bbf75427478dad1dfe32f44288)
* Allow template override using signedInTemplate [eaca425](http://github.com/Differential/accounts-entry/commit/eaca425e3a11e8d3fb4d3dc54d7f8ac8081be9a0)
* Added translation for "Email is required" [8249664](http://github.com/Differential/accounts-entry/commit/8249664d5a11362fb2407c2a9ccca0c11ee7cc22)
* Added t9n on error message [3af877b](http://github.com/Differential/accounts-entry/commit/3af877b1e2a0e9f48cf30ef7b9df20cd02afe598)
* Added translation for "User not found" to error: [5e8aaea](http://github.com/Differential/accounts-entry/commit/5e8aaea6dcbb0bddfc1a653b1b48274692783f1d)
* Translation for "Email already exists." [89feeba](http://github.com/Differential/accounts-entry/commit/89feeba821ee91ed7cff865394118d24725e63e7)
* Updated male/female addressing messages [6c26f20](http://github.com/Differential/accounts-entry/commit/6c26f20776580f047b189ce691eeb7106a88cb56)
* Added Incorrect password translation [ddeb56a](http://github.com/Differential/accounts-entry/commit/ddeb56a21874a4c7db9363d45b2a614a5d8b54fb)
* added slovene language [6ddaea2](http://github.com/Differential/accounts-entry/commit/6ddaea29d2c9062e43cceed62d7fe8f72e5d8e98)
* Add extra signup field support. [Fixes #179] [ea0667e](http://github.com/Differential/accounts-entry/commit/ea0667ea03aea3c17ca5093632513b590e38b5af)
* Get meteor developer accounts working a bit better. [be97ac8](http://github.com/Differential/accounts-entry/commit/be97ac850259018b3fedca3d41dee5ca2cc98bc6)
* added support for Portuguese. [d069af4](http://github.com/Differential/accounts-entry/commit/d069af48d2663ce91c2010f931d7bacd978395d8)
* added correct jquery selector for getting the entry [589f668](http://github.com/Differential/accounts-entry/commit/589f668ceaed838a167dcce1eddd0b599c74825e)
* Added support for Swedish. [28a4bc9](http://github.com/Differential/accounts-entry/commit/28a4bc9b5fe069187a5e1d011727daba0a8a9cfb)
* Pause is now a function passed to the onBeforeAction method. [b3a8a6d](http://github.com/Differential/accounts-entry/commit/b3a8a6d094e018ed90d53a2b1b9bfe233bdb3e43)
* Support Meteor accounts forbidClientAccountCreation. [4b64116](http://github.com/Differential/accounts-entry/commit/4b64116e05a419ba3448a7e4786ebb54d535933d)
* audit argument package support [256d5ef](http://github.com/Differential/accounts-entry/commit/256d5ef96a0ca53e5d8ec5beaa53ef71d52b353d)
* updating #143 which attempts to correct error #130 [09aaddd](http://github.com/Differential/accounts-entry/commit/09aaddd0651b72e13e3d20ebeee54b49e0c7ff5f)
* added italian translation [e8f5e68](http://github.com/Differential/accounts-entry/commit/e8f5e68183e42d247d331b95c3ab681fa6f45182)
* Update german.coffee [461991a](http://github.com/Differential/accounts-entry/commit/461991a37d6dcefe6f344e1382c8311a0b6339eb)

### 0.7.0

* Do not pull in spark or just-i18n dependencies, neither are directly needed anymore. [fc994c1](https://github.com/BeDifferential/accounts-entry/commit/fc994c1afe10dfcbb54b7aae2b0cf9fc5ba1f5b6)
* Add name attributes on signUp form to be consistent [#107](https://github.com/BeDifferential/accounts-entry/pull/107)
* Add emailToLower and usernameToLower settings so you can set the package to lowercase email input [#101](https://github.com/BeDifferential/accounts-entry/pull/101)
* Put autofocus on first field, not just on the email input. [#106](https://github.com/BeDifferential/accounts-entry/pull/106)
* Include the wrapLinks html, duh [7fb0e8e](http://github.com/Differential/accounts-entry/commit/7fb0e8e745852feb441661285207302bfa1e8441)
* Clean up wrapLinks for blaze, clean up test syntax now that include works, and add a new wrapLinks test. [7a3296c](http://github.com/Differential/accounts-entry/commit/7a3296cb044fe8c235fce0eab13f490456d67e6a)
* Fix tests to work with blaze now. [9966e90](http://github.com/Differential/accounts-entry/commit/9966e903ac7a53c391786ef475419e8e226cef21)
* Use the released version of just-i18n [d3d5185](http://github.com/Differential/accounts-entry/commit/d3d5185c5792db14050208e72dc167d97a42d943)
* redirect to correct page after social login [8aecc9c](http://github.com/Differential/accounts-entry/commit/8aecc9cc7a1865d43c895a84a36586a41c880d64)
* Oops, comma [77d7227](http://github.com/Differential/accounts-entry/commit/77d72275e54e3583294c15d915d5e1a6bc468e10)
* Try to fix accounts-t9n issues. [df238e8](http://github.com/Differential/accounts-entry/commit/df238e82dcb898fa3f3f8247743013ac08525f66)
* Fix just-i18n issues. Fixes #109 [c6daa42](http://github.com/Differential/accounts-entry/commit/c6daa42730a9001cbb166fb22a6f7b99e05a03c5)
* Adding ability to override accountButtons signup [4e82743](http://github.com/Differential/accounts-entry/commit/4e82743377ffd8abb153f1c59fc7afd7cf058be4)
* added sublime project files to gitignore and fix autofocus [9b10992](http://github.com/Differential/accounts-entry/commit/9b109922b54fd39c5284c91c9f1091dcaadab4d6)
* Changing setting name to usernameToLower and emailToLower, just struggled with insensitive and casesensitive keeping what they ment in my head, i think this is clearer [962a7c5](http://github.com/Differential/accounts-entry/commit/962a7c59fe40f121cb05bd4a391f3769cf96f375)
* Adding isStringEmail method to AccountsEntry [bafe044](http://github.com/Differential/accounts-entry/commit/bafe044bd564398e0cb342752caee6673c6a46c3)
* Adding check to make sure username is not an email address [398065d](http://github.com/Differential/accounts-entry/commit/398065d60f92680d8b251d18a2a5b46677be4f28)
* Adding error.usernameIsEmail to i18n, error text for different languages need check [c7ce0f6](http://github.com/Differential/accounts-entry/commit/c7ce0f68aa54dd6fca9b1005958be1e09204556d)
* Adding new settings for username and email Insensitive, adding check to signUp to make the username and email insensitive if needed [c5cbb06](http://github.com/Differential/accounts-entry/commit/c5cbb06489abb6360375d3f395cf5604d00d3385)

### 0.6.2

* Lock just-i18n to v0.1.1 since the refactors seem to break accounts-t9n which we rely on. [a58632](https://github.com/BeDifferential/accounts-entry/commit/a58632e95c0c59e72dd6edce71fa58fe50e8ce94)
* Fix signup form to work with USERNAME_ONLY, email field was causing errors. [#93](https://github.com/BeDifferential/accounts-entry/issues/93)
* Fix 'fromWhere' routing to work for both usernames and emails, was an oversight [#100](https://github.com/BeDifferential/accounts-entry/pull/100)
* Add polish translations [#90](https://github.com/BeDifferential/accounts-entry/pull/90)

### 0.6.1

* Bump iron-router version to 0.6.4. Still wish we had semvar support for dependencies [#96](https://github.com/BeDifferential/accounts-entry/issues/96)

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

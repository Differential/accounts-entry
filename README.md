accounts-entry
======================

A meteorite package that relies on Iron Router and gives you sign page login styles.

We wanted something to work with that used (Iron Router)[https://github.com/EventedMind/iron-router], Bootstrap 3, and didn't require the forcing of the dropdown box that didn't seem to be easily styled. But we love the ease of adding more packages like accounts-facebook or accounts-twitter, so we fully support the oauth packages by adding buttons to let people sign-up/sign-in with those services if you add them.  Right now it also assumes you will be using accounts-password, but we will likely make that optional in the future.

To get started just:

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

You can then either add links to those directly, or use the ````{{accountsButton}}```` helper we provide to give you the proper links.

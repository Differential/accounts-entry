This is a fork of joshowens:accounts-entry which uses Flow Router instead of Iron Router.

## Getting started

Install:

```
meteor add dovrosenberg:accounts-entry-flow
```

See the [original](https://github.com/Differential/accounts-entry) package for more details on usage and examples.  The differences are described here:

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

Use the helper function AccountsEntrySignInRequired in an entry trigger for any route that requires users to be signed in.  This will redirect the user to the included sign-in page and stop any rendering. Accounts-entry also tracks where the user was trying to go and will route them back after sign in.

Here is a route example:

````js
FlowRouter.route('/dashboard', {
		name: 'dashboard',
		triggersEnter: [
			AccountsEntrySignInRequired
		],
		action: function(params) {
			FlowLayout.render('dashboard');
		}
	}
);
````

You can also apply this to every route at once (making sure to exclude the logged out route):
````js
FlowRouter.triggers.enter([AccountsEntrySignInRequired], {except: ['loggedOut']});
````

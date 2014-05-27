if typeof Handlebars isnt "undefined"
  Handlebars.registerHelper "signedInAs", (date) ->
    if Meteor.user().username
      Meteor.user().username
    else if Meteor.user().profile && Meteor.user().profile.name
      Meteor.user().profile.name
    else if Meteor.user().emails and Meteor.user().emails[0]
      Meteor.user().emails[0].address
    else
      "Signed In"

Handlebars.registerHelper 'accountButtons', ->
  Template.entryAccountButtons

Handlebars.registerHelper 'capitalize', (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

Handlebars.registerHelper 'signupClass', ->
  if Accounts.oauth && Accounts.oauth.serviceNames().length > 0
    "collapse"

Handlebars.registerHelper 'signedIn', ->
  return true if Meteor.user()

Handlebars.registerHelper 'otherLoginServices', ->
  Accounts.oauth &&
  Accounts.oauth.serviceNames().length > 0

Handlebars.registerHelper 'loginServices', ->
  Accounts.oauth.serviceNames()

Handlebars.registerHelper 'showSignupCode', ->
  AccountsEntry.settings.showSignupCode is true

Handlebars.registerHelper 'passwordLoginService', ->
  !!Package['accounts-password']

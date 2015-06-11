if typeof Handlebars isnt "undefined"
  UI.registerHelper "signedInAs", (date) ->
    if Meteor.user().username
      Meteor.user().username
    else if Meteor.user().profile && Meteor.user().profile.name
      Meteor.user().profile.name
    else if Meteor.user().emails and Meteor.user().emails[0]
      Meteor.user().emails[0].address
    else
      "Signed In"

UI.registerHelper 'accountButtons', ->
  Template.entryAccountButtons

UI.registerHelper 'capitalize', (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

UI.registerHelper 'signupClass', ->
  if AccountsEntry.settings.showOtherLoginServices && Accounts.oauth && Accounts.oauth.serviceNames().length > 0
    "collapse"

UI.registerHelper 'signedIn', ->
  return true if Meteor.user()

UI.registerHelper 'otherLoginServices', ->
  AccountsEntry.settings.showOtherLoginServices &&
  Accounts.oauth &&
  Accounts.oauth.serviceNames().length > 0

UI.registerHelper 'loginServices', ->
  Accounts.oauth.serviceNames()

UI.registerHelper 'showSignupCode', ->
  AccountsEntry.settings.showSignupCode is true

UI.registerHelper 'passwordLoginService', ->
  !!Package['accounts-password']

UI.registerHelper 'showCreateAccountLink', ->
  return !Accounts._options.forbidClientAccountCreation


class @Helper
  @disableBtns = ($btns) ->
    $btns.html($btns.html()+' <i class="fa fa-spinner fa-animate"></i>')
    $btns.attr("disabled", "disabled")

  @enableBtns = ($btns) ->
    $btns.html(s.strLeft($btns.html(),' <i class="fa fa-spinner fa-animate"></i>'))
    $btns.attr("disabled", null)
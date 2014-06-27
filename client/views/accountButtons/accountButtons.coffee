entryAccountButtonsHelpers = {
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    AccountsEntry.settings.profileRoute


  wrapLinksLi: ->
    if AccountsEntry.settings.wrapLinks
      Template.wrapLinks
    else
      Template.noWrapLinks

  wrapLinks: ->
    AccountsEntry.settings.wrapLinks

  beforeSignIn: ->
    AccountsEntry.settings.beforeSignIn

  beforeSignUp: ->
    AccountsEntry.settings.beforeSignUp

  beforeSignOut: ->
    AccountsEntry.settings.beforeSignOut

  beforeSignedInAs: ->
    AccountsEntry.settings.beforeSignedInAs

  entrySignUp: ->
    AccountsEntry.settings.entrySignUp

  profile: ->
    Meteor.user().profile
}

Template.entryAccountButtons.helpers entryAccountButtonsHelpers

Template.entryAccountButtons.helpers
  signedInTemplate: ->
    if AccountsEntry.settings.signedInTemplate
      Template[AccountsEntry.settings.signedInTemplate].helpers(entryAccountButtonsHelpers)
      Template[AccountsEntry.settings.signedInTemplate]
    else
      Template.entrySignedIn

Template.entrySignedIn.helpers entryAccountButtonsHelpers

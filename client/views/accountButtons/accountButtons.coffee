Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    AccountsEntry.settings.profileRoute

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

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    AccountsEntry.settings.profileRoute

  wrapLinksOpenLi: ->
    Spacebars.SafeString("<li>") if AccountsEntry.settings.wrapLinks

  wrapLinksCloseLi: ->
    Spacebars.SafeString("</li>") if AccountsEntry.settings.wrapLinks

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

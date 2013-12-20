Template.entryAccountButtons.helpers AccountsEntry.templateHelpers

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    AccountsEntry.settings.profileRoute

  wrapLinks: ->
    AccountsEntry.settings.wrapLinks




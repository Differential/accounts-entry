Handlebars.registerHelper 'accountButtons', ()->
  throw new Error("Use {{> entryAccountButtons}} instead of {{accountButtons}}")

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    AccountsEntry.settings.profileRoute

  wrapLinks: ->
    AccountsEntry.settings.wrapLinks

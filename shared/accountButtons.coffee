Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.entryAccountButtons())
  )

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    Router.path(AccountsEntry.settings.profileRoute)

  wrapLinks: ->
    AccountsEntry.settings.wrapLinks

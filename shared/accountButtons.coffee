Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.entryAccountButtons())
  )

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.config.profileRoute
    Router.path(AccountsEntry.config.profileRoute)

Template.entryAccountButtons.helpers
  wrapLinks: ->
    AccountsEntry.config.wrapLinks

  showUserName: ->
    AccountsEntry.config.showUserName

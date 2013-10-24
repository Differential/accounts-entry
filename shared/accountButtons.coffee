Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.entryAccountButtons())
  )

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless Meteor.call('entryProfileRoute')
    Router.path(Meteor.call('entryProfileRoute'))

  wrapLinks: ->
    AccountsEntry.settings.wrapLinks

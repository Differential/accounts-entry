Meteor.call('entrySettings', (err, data) ->
  if err
    console.log err

  Session.set('entrySettings', data)
)

Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.entryAccountButtons())
  )

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless Meteor.call('entryProfileRoute')
    Router.path(Meteor.call('entryProfileRoute'))

  wrapLinks: ->
    Session.get('entrySettings').wrapLinks

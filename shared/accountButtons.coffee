Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.entryAccountButtons())
  )

Template.entryAccountButtons.helpers
  signedInAs: ->
    if Meteor.user().username
      Meteor.user().username
    else if Meteor.user().profile.name
      Meteor.user().profile.name
    else if Meteor.user().emails and Meteor.user().emails[0]
      Meteor.user().emails[0].address
    else
      "Logged In"

  profileUrl: ->
    return false unless Meteor.call('entryProfileRoute')
    Router.path(Meteor.call('entryProfileRoute'))

Template.entryAccountButtons.events
  "click .entry-sign-out": (event) ->
    event.preventDefault()
    if Meteor.call('entryHomeRoute')
      Meteor.logout()
      Router.go(Meteor.call('entryHomeRoute'))

Template.entryAccountButtons.helpers
  wrapLinks: ->
    Meteor.call('entryWrapLinks')

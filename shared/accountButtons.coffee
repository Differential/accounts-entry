Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.differentialAccountButtons())
  )

Template.differentialAccountButtons.helpers
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
    Router.path(AccountsEntry.config.profileRoute)

Template.differentialAccountButtons.events
  "click .differential-sign-out": (event) ->
    event.preventDefault()
    if AccountsEntry.config.homeRoute
      Meteor.logout()
      Router.go(AccountsEntry.config.homeRoute)

Template.differentialAccountButtons.helpers
  wrapLinks: ->
    AccountsEntry.config.wrapLinks

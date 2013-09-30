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
    return false unless AccountsEntry.config.profileRoute
    Router.path(AccountsEntry.config.profileRoute)

Template.entryAccountButtons.events
  "click .entry-sign-out": (event) ->
    event.preventDefault()
    if AccountsEntry.config.homeRoute
      Meteor.logout()
      Router.go(AccountsEntry.config.homeRoute)

Template.entryAccountButtons.helpers
  wrapLinks: ->
    AccountsEntry.config.wrapLinks

  showUserName: ->
    AccountsEntry.config.showUserName

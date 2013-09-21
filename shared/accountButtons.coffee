Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.differentialAccountButtons())
  )

Template.differentialAccountButtons.helpers
  signedInAs: ->
    Meteor.user().username || Meteor.user().emails[0].address

  profileUrl: ->
    AccountsEntry.config.profileRoute

Template.differentialAccountButtons.events
  "click .differential-sign-out": (event) ->
    event.preventDefault()
    if AccountsEntry.config.homeRoute
      Meteor.logout()
      Router.go(AccountsEntry.config.homeRoute)

Template.differentialAccountButtons.helpers
  wrapLinks: ->
    AccountsEntry.config.wrapLinks

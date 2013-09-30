Handlebars.registerHelper(
  "accountButtons", ->
      console.log "accountButtons."
      return new Handlebars.SafeString(Template.entryAccountButtons())
  )

Template.entryAccountButtons.helpers
  signedInAs: ->
    Meteor.user().username ?
    (Meteor.user().profile?.name ?
    (Meteor.user().emails[0]?.address ? "Logged In"))

  profileUrl: ->
    return false unless AccountsEntry.config.profileRoute
    Router.path(AccountsEntry.config.profileRoute)

Template.entryAccountButtons.events
  "click .differential-sign-out": (event) ->
    event.preventDefault()
    if AccountsEntry.config.homeRoute
      Meteor.logout()
      Router.go(AccountsEntry.config.homeRoute)

Template.entryAccountButtons.helpers
  wrapLinks: ->
    AccountsEntry.config.wrapLinks

  showUserName: ->
    AccountsEntry.config.showUserName

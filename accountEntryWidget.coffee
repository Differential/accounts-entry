
Template.accountEntryWidget.helpers
  inline: ->
      AccountsEntry.config.inline

  signedInAs: ->
    Meteor.user().username ?
    (Meteor.user().profile?.name ?
    (Meteor.user().emails[0]?.address ? "Logged In"))

  profileUrl: ->
    return false unless AccountsEntry.config.profileRoute
    Router.path(AccountsEntry.config.profileRoute)

  wrapLinks: ->
    AccountsEntry.config.wrapLinks

  showUserName: ->
    AccountsEntry.config.showUserName

Template.accountEntryWidget.events
  "click .sign-out": (event) ->
    event.preventDefault()
    if AccountsEntry.config.homeRoute
      Meteor.logout()
      Router.go AccountsEntry.config.homeRoute


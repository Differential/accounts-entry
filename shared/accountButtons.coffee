Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.differentialAccountButtons())
  )

Template.differentialAccountButtons.events
  "click .differential-sign-out": (event) ->
    event.preventDefault()
		Meteor.logout()
    if AccountsEntry.config.homeRoute
      Router.go(AccountsEntry.config.homeRoute)

Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.differentialAccountButtons())
  )

Template.differentialAccountButtons.helpers
Template.differentialAccountButtons.events
  "click .differential-sign-out": (event) ->
    event.preventDefault()
		Meteor.logout()
		Router.go('/')

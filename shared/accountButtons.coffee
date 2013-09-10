Handlebars.registerHelper(
  "accountButtons", ->
    return new Handlebars.SafeString(Template.differentialAccountButtons())
  )

Template.differentialAccountButtons.helpers
Template.differentialAccountButtons.events

Handlebars.registerHelper 'capitalize', (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

Handlebars.registerHelper 'otherLoginServices', ->
  Accounts.oauth &&
  Accounts.oauth.serviceNames().length > 0

Handlebars.registerHelper 'loginServices', ->
  Accounts.oauth.serviceNames()

Template.entrySignUp.helpers
  showEmail: ->
    fields = Accounts.ui._options.passwordSignupFields

    _.contains([
      'USERNAME_AND_EMAIL',
      'USERNAME_AND_OPTIONAL_EMAIL',
      'EMAIL_ONLY'], fields)

  showUsername: ->
    fields = Accounts.ui._options.passwordSignupFields

    _.contains([
      'USERNAME_AND_EMAIL',
      'USERNAME_AND_OPTIONAL_EMAIL',
      'USERNAME_ONLY'], fields)

  logo: ->
    AccountsEntry.config.logo

  privacyUrl: ->
    AccountsEntry.config.privacyUrl

  termsUrl: ->
    AccountsEntry.config.termsUrl

  both: ->
    AccountsEntry.config.privacyUrl &&
    AccountsEntry.config.termsUrl

  neither: ->
    !AccountsEntry.config.privacyUrl &&
    !AccountsEntry.config.termsUrl


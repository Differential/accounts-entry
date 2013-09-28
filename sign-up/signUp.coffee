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

Template.entrySignUp.events
  'submit #signUp': (event) ->
    event.preventDefault()
    username = $('input[type="string"]').val()
    email = $('input[type="email"]').val()
    password = $('input[type="password"]').val()

    fields = Accounts.ui._options.passwordSignupFields

    emailRequired = _.contains([
      'USERNAME_AND_EMAIL',
      'EMAIL_ONLY'], fields)

    usernameRequired = _.contains([
      'USERNAME_AND_EMAIL',
      'USERNAME_ONLY'], fields)

    if usernameRequired && email.length is 0
      Session.set('error', 'Username is required')
      return

    if emailRequired && email.length is 0
      Session.set('error', 'Email is required')
      return

    if password.length is 0
      Session.set('error', 'Password is required')
      return

    Accounts.createUser({
      username: username,
      email: email,
      password: password,
      profile: {}
      }, (error)->
        if error
          Session.set('error', error.reason)
        else
          Router.go(AccountsEntry.config.dashboardRoute)
    )

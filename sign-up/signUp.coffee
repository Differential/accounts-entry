Handlebars.registerHelper 'capitalize', (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

Handlebars.registerHelper 'otherLoginServices', ->
  Accounts.oauth &&
  Accounts.oauth.serviceNames().length > 0

Handlebars.registerHelper 'loginServices', ->
  Accounts.oauth.serviceNames()

Template.differentialSignUp.helpers
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

Template.differentialSignUp.events
  'submit #signUp': (event) ->
    event.preventDefault()
    email = $('input[type="email"]').val()
    password = $('input[type="password"]').val()

    if email.length is 0
      Session.set('error', 'Email is required')
      return

    if password.length is 0
      Session.set('error', 'Password is required')
      return

    Accounts.createUser({
      email: email,
      password: password
      }, (error)->
        if error
          Session.set('error', error.reason)
        else
          Router.go('/dashboard')
    )

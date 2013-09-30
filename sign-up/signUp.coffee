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
  'submit #signUp': (event, t) ->
      event.preventDefault()
      username = t.find('input[type="string"]')?.value? || undefined
      email = t.find('input[type="email"]').value
      password = t.find('input[type="password"]').value

      fields = Accounts.ui._options.passwordSignupFields

      trimInput = (val)->
          val.replace /^\s*|\s*$/g, ""

      passwordErrors = do (password)->
          errMsg = []
          msg = false
          if password.length < 7
              errMsg.push "7 character minimum password."
          if password.search(/[a-z]/i) < 0
              errMsg.push "Password requires 1 letter."
          if password.search(/[0-9]/) < 0
              errMsg.push "Password must have at least one digit."

          if errMsg.length > 0
              msg = ""
              errMsg.forEach (e) ->
                  msg = msg.concat "#{e}\r\n"

              Session.set 'entryError', msg
              return true

          return false

      if passwordErrors then return

      email = trimInput email

      emailRequired = _.contains([
          'USERNAME_AND_EMAIL',
          'EMAIL_ONLY'], fields)

      usernameRequired = _.contains([
          'USERNAME_AND_EMAIL',
          'USERNAME_ONLY'], fields)

      if usernameRequired && email.length is 0
          Session.set('entryError', 'Username is required')
          return

      if emailRequired && email.length is 0
          Session.set('entryError', 'Email is required')
          return

      Accounts.createUser({
          username: username,
          email: email,
          password: password,
          profile: AccountsEntry.config.defaultProfile || {}
      }, (error)->
          if error
              Session.set('entryError', error.reason)
          else
              Router.go(AccountsEntry.config.dashboardRoute)
      )

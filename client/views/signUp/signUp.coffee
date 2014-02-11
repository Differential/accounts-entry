signUpErrorMap = {
  'User validation failed': 'error.userValidationFailed',
  'Email already exists.': 'error.emailAlreadyExists',
  'Username already exists.': 'error.usernameAlreadyExists'
}

Template.entrySignUp.helpers
  showEmail: ->
    fields = AccountsEntry.settings.passwordSignupFields

    _.contains([
      'USERNAME_AND_EMAIL',
      'USERNAME_AND_OPTIONAL_EMAIL',
      'EMAIL_ONLY'], fields)

  showUsername: ->
    fields = AccountsEntry.settings.passwordSignupFields

    _.contains([
      'USERNAME_AND_EMAIL',
      'USERNAME_AND_OPTIONAL_EMAIL',
      'USERNAME_ONLY'], fields)

  showSignupCode: ->
    AccountsEntry.settings.showSignupCode

  logo: ->
    AccountsEntry.settings.logo

  privacyUrl: ->
    AccountsEntry.settings.privacyUrl

  termsUrl: ->
    AccountsEntry.settings.termsUrl

  both: ->
    AccountsEntry.settings.privacyUrl &&
    AccountsEntry.settings.termsUrl

  neither: ->
    !AccountsEntry.settings.privacyUrl &&
    !AccountsEntry.settings.termsUrl

  emailIsOptional: ->
    fields = AccountsEntry.settings.passwordSignupFields

    _.contains(['USERNAME_AND_OPTIONAL_EMAIL'], fields)

Template.entrySignUp.events
  'submit #signUp': (event, t) ->
    event.preventDefault()

    username =
      if t.find('input[name="username"]')
        t.find('input[name="username"]').value
      else
        undefined

    signupCode =
      if t.find('input[name="signupCode"]')
        t.find('input[name="signupCode"]').value
      else
        undefined

    email = t.find('input[type="email"]').value
    password = t.find('input[type="password"]').value

    fields = AccountsEntry.settings.passwordSignupFields

    trimInput = (val)->
      val.replace /^\s*|\s*$/g, ""

    passwordErrors = do (password)->
      errMsg = []
      msg = false
      if password.length < 7
        errMsg.push i18n("error.minChar")
      if password.search(/[a-z]/i) < 0
        errMsg.push i18n("error.pwOneLetter")
      if password.search(/[0-9]/) < 0
        errMsg.push i18n("error.pwOneDigit")

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

    if usernameRequired && username.length is 0
      Session.set('entryError', i18n("error.uernameRequired"))
      return

    if emailRequired && email.length is 0
      Session.set('entryError', i18n("error.emailRequired"))
      return

    if AccountsEntry.settings.showSignupCode && signupCode.length is 0
      Session.set('entryError', i18n("error.signupCodeRequired"))
      return


    Meteor.call('entryValidateSignupCode', signupCode, (err, valid) ->
      if err
        console.log err
      if valid
        newUserData =
          email: email
          password: password
          profile: AccountsEntry.settings.defaultProfile || {}
        if username
          data.username = username
        Accounts.createUser newUserData, (err, data) ->
          if err
            errorMsg = signUpErrorMap[err.reason]
            errorMsg = 'error.unknown' if errorMsg is undefined
            Session.set('entryError', i18n(errorMsg))
            return
          #login on client
          if  _.contains([
            'USERNAME_AND_EMAIL',
            'EMAIL_ONLY'], AccountsEntry.settings.passwordSignupFields)
            Meteor.loginWithPassword(email, password, (error) ->
              if error
                Session.set('entryError', i18n("error.unknown"))
              else
                Router.go AccountsEntry.settings.dashboardRoute
            )
          else
            Meteor.loginWithPassword(username, password, (error) ->
              if error
                Session.set('entryError', i18n("error.unknown"))
              else
                Router.go AccountsEntry.settings.dashboardRoute
            )
      else
        Session.set('entryError', i18n("error.signupCodeIncorrect"))
        return
    )


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

    if AccountsEntry.settings.showSignupCode && signupCode.length is 0
      Session.set('entryError', 'Signup code is required')
      return

    Meteor.call('entryValidateSignupCode', signupCode, (err, valid) ->
      if err
        console.log err
      if valid
        Meteor.call('accountsCreateUser', username, email, password, (err, data) ->
          if err
            Session.set('entryError', err.reason)
            return


          #login on client
          if  _.contains([
            'USERNAME_AND_EMAIL',
            'USERNAME_AND_OPTIONAL_EMAIL',
            'EMAIL_ONLY'], Accounts.ui._options.passwordSignupFields)
            Meteor.loginWithPassword(email, password)
          else
            Meteor.loginWithPassword(username, password)

          Router.go AccountsEntry.settings.dashboardRoute
        )
      else
        Session.set('entryError', 'Signup code is incorrect')
        return
    )


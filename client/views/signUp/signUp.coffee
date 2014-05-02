AccountsEntry.entrySignUpHelpers = {
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

  showProfile: ->
    AccountsEntry.settings.showProfile

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

  emailAddress: ->
    Session.get('email')
}

AccountsEntry.entrySignUpEvents = {
  'submit #signUp': (event, t) ->
    event.preventDefault()

    firstName =
      if t.find('input[name="firstName"]')
        t.find('input[name="firstName"]').value
      else undefined

    lastName =
      if t.find('input[name="lastName"]')
        t.find('input[name="lastName"]').value
      else undefined

    organization =
      if t.find('input[name="organization"]')
        t.find('input[name="organization"]').value
      else undefined

    username =
      if t.find('input[name="username"]')
        t.find('input[name="username"]').value.toLowerCase()
      else if firstName and lastName
        firstName + lastName
      else
        undefined
    if username and AccountsEntry.settings.usernameToLower then username = username.toLowerCase()

    signupCode =
      if t.find('input[name="signupCode"]')
        t.find('input[name="signupCode"]').value
      else
        undefined

    trimInput = (val)->
      val.replace /^\s*|\s*$/g, ""

    email =
      if t.find('input[type="email"]')
        trimInput t.find('input[type="email"]').value
      else
        undefined
    if AccountsEntry.settings.emailToLower and email then email = email.toLowerCase()

    password = t.find('input[type="password"]').value

    fields = AccountsEntry.settings.passwordSignupFields


    passwordErrors = do (password)->
      errMsg = []
      msg = false
      if password.length < 7
        errMsg.push t9n("error.minChar")
      if password.search(/[a-z]/i) < 0
        errMsg.push t9n("error.pwOneLetter")
      if password.search(/[0-9]/) < 0
        errMsg.push t9n("error.pwOneDigit")

      if errMsg.length > 0
        msg = ""
        errMsg.forEach (e) ->
          msg = msg.concat "#{e}\r\n"

        Session.set 'entryError', msg
        return true

      return false

    if passwordErrors then return

    emailRequired = _.contains([
      'USERNAME_AND_EMAIL',
      'EMAIL_ONLY'], fields)

    usernameRequired = _.contains([
      'USERNAME_AND_EMAIL',
      'USERNAME_ONLY'], fields)

    if AccountsEntry.settings.profileRequired && firstName.length is 0
      Session.set('entryError', "First name is required.")
      return

    if AccountsEntry.settings.profileRequired && lastName.length is 0
      Session.set('entryError', "Last name is required.")
      return

    if AccountsEntry.settings.profileRequired && organization.length is 0
      Session.set('entryError', "Organization is required.")
      return

    if usernameRequired && username.length is 0
      Session.set('entryError', t9n("error.usernameRequired"))
      return

    if username && AccountsEntry.isStringEmail(username)
      Session.set('entryError', t9n("error.usernameIsEmail"))
      return

    if emailRequired && email.length is 0
      Session.set('entryError', t9n("error.emailRequired"))
      return

    if AccountsEntry.settings.showSignupCode && signupCode.length is 0
      Session.set('entryError', t9n("error.signupCodeRequired"))
      return


    Meteor.call 'entryValidateSignupCode', signupCode, (err, valid) ->
      if valid
        newUserData =
          username: username
          email: email
          password: password
          profile:
            firstName: firstName
            lastName: lastName
            name: firstName + " " + lastName
            organization: organization
        Accounts.createUser newUserData, (err, data) ->
          if err
            T9NHelper.accountsError err
            return
          #login on client
          isEmailSignUp = _.contains([
            'USERNAME_AND_EMAIL',
            'EMAIL_ONLY'], AccountsEntry.settings.passwordSignupFields)
          userCredential = if isEmailSignUp then email else username
          Meteor.loginWithPassword userCredential, password, (error) ->
            if error
              T9NHelper.accountsError error
            else if Session.get 'fromWhere'
              Router.go Session.get('fromWhere')
              Session.set 'fromWhere', undefined
            else
              Router.go AccountsEntry.settings.dashboardRoute
      else
        console.log err
        Session.set 'entryError', t9n("error.signupCodeIncorrect")
        return
}

Template.entrySignUp.helpers(AccountsEntry.entrySignUpHelpers)

Template.entrySignUp.events(AccountsEntry.entrySignUpEvents)

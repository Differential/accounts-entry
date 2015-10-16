AccountsEntry.hashPassword = (password) ->
  digest: SHA256(password),
  algorithm: "sha-256"

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

  # validZipArea: ->
  #   Session.get('validZipCode')

  # zipCodeHelp: ->
  #   Session.get('zipCodeHelp')
}

AccountsEntry.entrySignUpEvents = {

  # 'keypress #zipCode': (e, t) ->
  #   setTimeout ( ->
  #     len = $(e.target).val().toString().length;
  #     if len < 5
  #       left = 5-len+""
  #       Session.set("zipCodeHelp", "Only " + left + " more number(s) needed for a valid zip code.")
  #     else if len is 5
  #       if Match.test({zip: $(e.target).val()}, Schema.Zip)
  #         Session.set("validZipCode", true);
  #         Session.set("zipCodeHelp", null)
  #       else
  #         Session.set("zipCodeHelp", "We apologize, but it appears we do not provide service in your area. If you'd like to see service in your area, drop us a note via our contact page.")
  #     else if len > 5
  #       console.log("bad")
  #   ) , 100


  #WIP
  # 'focusin #popover-password-input': () ->
  #   $('#popover-password-div').toggleClass('input-group')
  #   $('#password-popover').toggleClass('hidden')
  #
  # 'focusout #popover-password-input': () ->
  #   $('#password-popover').addClass('hidden')
  #   $('#popover-password-div').removeClass('input-group')

  # 'click #password-popover': (e) ->
  #   $(this).hover.call(this)

  'submit #signUp': (event, t) ->
    event.preventDefault()

    username =
      if t.find('input[name="username"]')
        t.find('input[name="username"]').value.toLowerCase()
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

    formValues = SimpleForm.processForm(event.target)
    extraFields = _.pluck(AccountsEntry.settings.extraSignUpFields, 'field')
    filteredExtraFields = _.pick(formValues, extraFields)
    password = t.find('input[type="password"]').value

    fields = AccountsEntry.settings.passwordSignupFields


    passwordErrors = do (password)->
      errMsg = []
      msg = false
      if password.length < 7
        errMsg.push t9n("error.minChar")
      if password.search(/[a-z]/i) < 0
        errMsg.push t9n("error.pwOneLetter")
      if password.search(/[A-Z]/) < 0
        errMsg.push t9n("error.pwUpperLower")
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
          password: AccountsEntry.hashPassword(password)
          profile: filteredExtraFields
        Meteor.call 'entryCreateUser', newUserData, (err, data) ->
          if err
            console.log err
            T9NHelper.accountsError err
            return
          #login on client
          isEmailSignUp = _.contains([
            'USERNAME_AND_EMAIL',
            'EMAIL_ONLY'], AccountsEntry.settings.passwordSignupFields)
          userCredential = if isEmailSignUp then email else username
          Meteor.loginWithPassword userCredential, password, (error) ->
            if error
              console.log error
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

AccountsEntry.entrySignUpHooks = {
  rendered: ->
    console.log "Sign Up"
    $('[data-toggle="popover"]').popover()
    # $("#password-popover").popover({ trigger: "hover", container: "body" })
}


Template.entrySignUp.helpers(AccountsEntry.entrySignUpHelpers)

Template.entrySignUp.events(AccountsEntry.entrySignUpEvents)

Template.entrySignUp.hooks(AccountsEntry.entrySignUpHooks)

Template.identityInput.helpers
   emailPlaceholder: ->
       fields = Accounts.ui._options.passwordSignupFields
       if _.contains([
           'USERNAME_AND_EMAIL'
           'USERNAME_AND_OPTIONAL_EMAIL'
       ], fields) then return 'Username or email'
       else
           return 'Email'

   emailOnly: ->
       Accounts.ui._options.passwordSignupFields is 'EMAIL_ONLY'

   entryIdentity: ->
       id = Session.get('entryIdentity')  ? ""

Template.identityInput.rendered = ->
    f = @firstNode.form
    $(f)?.find('input#identityInput').parsley('destroy')?.parsley()
    true

Template.passwordInput.helpers
   entryPassword: ->
       pw = Session.get('entryPassword') ? ""

Template.passwordInput.rendered = (params)->
    f = @firstNode.form
    $(f)?.find('input#passwordInput').parsley('destroy').parsley({
        validators: {
            hasnumber: (val, hasnumber) ->
                if /[0-9]/.test val
                    return true
                else
                    return false
            hasletter: (val, hasletter) ->
                if /[A-Za-z]/.test val
                    return true
                else
                    return false
        },
        messages: {
            hasnumber: "Password requires %s numbers."
            hasletter: "Password requires %s letters."
        }
    })
    true

getSign = (text)->
    if AccountsEntry.config.icons is true
        switch text
            when "Sign Up"
                type = "edit"
            when "Sign In"
                type = "log-in"
            when "Sign Out"
                type = "log-out"
            else
                type = "asterisk"

        return '<span class="glyphicon glyphicon-'+type+'></span>'+text
    else
        return text

Template.entrySignUpButton.helpers
      sign: ->
          getSign "Sign Up"

Template.entrySignOutButton.helpers
      sign: ->
          getSign "Sign Out"

Template.entrySignInButton.helpers
      sign: ->
          getSign "Sign In"

Template.entrySignInButton.events
    "click button#entrySignInButton": (e, t)->
        e.preventDefault()
        if not $('[data-type="email"]').parsley('isValid') then return
        email = $('#identityInput').val()
        password = $('#passwordInput').val()
        email = email.replace /^\s*|\s*$/g, ""
        Meteor.loginWithPassword email, password, (err)->
            if err
                switch err.reason
                    when "User not found"
                        Session.set 'entryIdentity', email
                        Session.set 'entryPassword', password
                        Router.go "/sign-in"
                        n = new Noty {type: 'error', layout: 'topRight', text: err.reason}
                    when "Incorrect password"
                        a = new Noty {type: 'error', layout: 'topRight', text: err.reason}
                    else
                        a = new Noty {type: 'error', layout: 'topRight', text: err.reason}
            a = new Noty {type: 'success', layout: 'topRight',  text: "Welcome back."}


Template.entrySignUpButton.events
    "click #entrySignUpButton": (e,t) ->
        e.preventDefault()
        password = $('#passwordInput').val()
        fields = Accounts.ui._options.passwordSignupFields

        emailRequired = _.contains([
            'USERNAME_AND_EMAIL',
            'EMAIL_ONLY'], fields)

        usernameRequired = _.contains([
            'USERNAME_AND_EMAIL',
            'USERNAME_ONLY'], fields)

        if usernameRequired
            if not $('[data-type="alphanum"]').parsley('isValid') then return
        username = $('[data-type="alphanum"]').val()
        username = username?.replace? /^\s*|\s*$/g, ""

        if emailRequired
            if not $('[data-type="email"]').parsley('isValid') then return
        email = $('[data-type="email"]').val()
        email = email?.replace? /^\s*|\s*$/g, ""

        Accounts.createUser({
            username: username,
            email: email,
            password: password,
            profile: AccountsEntry.config.defaultProfile || {}
        }, (error)->
            if error?
                Alerts.insert new ErrorAlert error.reason
            else
                Alerts.insert new SuccessAlert 'Account creation success!'
                Router.go AccountsEntry.config.dashboardRoute
        )


@AccountsEntry = {
  config:
    wrapLinks: true
    homeRoute: 'home'
    dashboardRoute: 'dashboard'
}

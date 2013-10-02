Template.identityInput.helpers
   identityPlaceholder: ->
       fields = Accounts.ui._options.passwordSignupFields
       if _.contains([
           'USERNAME_AND_EMAIL'
           'USERNAME_AND_OPTIONAL_EMAIL'
       ], fields) then return 'Username or email'
       else
           return 'Email'

   emailOnly: ->
       Accounts.ui._options.passwordSignupFields is 'EMAIL_ONLY'
   entryType: 'Multi'

   entryIdentity: ()->
       id = Session.get('entryIdentity')  ? ""

Template.identityInput.rendered = ->
    f = @firstNode.form
    $(f)?.find('input#identityInput').parsley('destroy')?.parsley()
    true

Template.emailInput.helpers
   emailPlaceholder: "Email"
   entryEmail: ()->
       id = Session.get('entryEmail')  ? ""

Template.emailInput.rendered = ->
    f = @firstNode.form
    $(f)?.find('input#emailInput').parsley('destroy')?.parsley()
    true

Template.usernameInput.helpers
   usernamePlaceholder: "username"
   entryUsername: ()->
       id = Session.get('entryUsername')  ? ""

Template.usernameInput.rendered = ->
    f = @firstNode.form
    $(f)?.find('input#usernameInput').parsley('destroy')?.parsley()
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
        hasErrors = false
        e.preventDefault()
        f= t.firstNode.form
        $f = $ f
        if not $f.find('#passwordInput').parsley('isValid')
            new Noty {
                    type: 'error'
                    layout: 'topRight'
                    timeout: 4200
                    text: 'A valid password is required for signin.'
                }
            hasErrors = true

        if not $f.find('#identityInput').parsley('isValid')
            new Noty {
                    type: 'error'
                    layout: 'topRight'
                    timeout: 4200
                    text: 'An valid identity is required for signin.'
                }
            hasErrors = true

        if hasErrors then return

        email = $f.find('#identityInput').val()
        password = $f.find('#passwordInput').val()
        email = email.replace /^\s*|\s*$/g, ""
        Meteor.loginWithPassword email, password, (err)->
            if err
                switch err.reason
                    when "User not found"
                        Session.set 'entryIdentity', email
                        Session.set 'entryPassword', password
                        Router.go "/sign-in"
                        new Noty {
                            closeWith: ['hover']
                            timeout: 5100
                            type: 'error'
                            layout: 'topRight'
                            text: err.reason
                        }
                    when "Incorrect password"
                        new Noty {
                            timeout: 5100
                            closeWith: ['hover']
                            type: 'error'
                            layout: 'topRight'
                            text: err.reason
                        }
                    else
                         new Noty {
                             timeout: 5100
                             type: 'error'
                             layout: 'topRight'
                             text: err.reason
                         }
            else
                new Noty {
                    timeout: 5100
                    closeWith: ['hover']
                    type: 'success'
                    layout: 'topRight'
                    text: "Welcome back."
                }


Template.entrySignUpButton.events
    "click #entrySignUpButton": (e,t) ->
        hasErrors = false
        e.preventDefault()
        f= t.firstNode.form
        $f = $ f
        if not $f.find('#passwordInput').parsley('isValid')
            new Noty {
                type: 'error'
                layout: 'topRight'
                timeout: 4200
                text: 'A valid password is required for signup.'
            }
            hasErrors = true

        fields = Accounts.ui._options.passwordSignupFields

        emailRequired = _.contains([
            'USERNAME_AND_EMAIL',
            'EMAIL_ONLY'], fields)

        usernameRequired = _.contains([
            'USERNAME_AND_EMAIL',
            'USERNAME_ONLY'], fields)

        if usernameRequired
            if not $f.find('#usernameInput').parsley('isValid')
                new Noty {
                    type: 'error'
                    layout: 'topRight'
                    timeout: 4200
                    text: 'A username is required for signup.'
                }
                hasErrors = true

        if emailRequired
            if not $f.find('[data-type="email"]').parsley('isValid')
                new Noty {
                    type: 'error'
                    layout: 'topRight'
                    timeout: 4200
                    text: 'A valid email address is required for signup.'
                }
                hasErrors = true

        if hasErrors
            Router.go '/sign-up'
            return

        password = $f.find('#passwordInput').val()
        Session.set 'entryPassword', password
        username = $f.find('#usernameInput').val()
        username = username?.replace? /^\s*|\s*$/g, ""
        Session.set 'entryUsername', username
        email = $f.find('[data-type="email"]').val()
        email = email?.replace? /^\s*|\s*$/g, ""
        Session.set 'entryEmail', email

        Accounts.createUser({
            username: username,
            email: email,
            password: password,
            profile: AccountsEntry.config.defaultProfile || {}
        }, (error)->
            if error?
                new Noty {
                    timeout: 5100
                    closeWith: ['hover']
                    type: 'error'
                    layout: 'topRight'
                    text: error.reason
                }
            else
                new Noty {
                    timeout: 5100
                    closeWith: ['hover']
                    type: 'success'
                    layout: 'topRight'
                    text: 'Welcome new user.'
                }
                Router.go AccountsEntry.config.dashboardRoute
        )


@AccountsEntry = {
  config:
    wrapLinks: true
    homeRoute: 'home'
    dashboardRoute: 'dashboard'
}

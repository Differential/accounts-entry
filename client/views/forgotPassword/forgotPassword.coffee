Template.entryForgotPassword.helpers
  error: -> t9n(Session.get('entryError'))

  logo: ->
    AccountsEntry.settings.logo

Template.entryForgotPassword.events
  'submit #forgotPassword': (event) ->
    event.preventDefault()
    Session.set('entryError', null)

    email = $('input[name="forgottenEmail"]').val()
    if (AccountsEntry.isStringEmail(email) and AccountsEntry.settings.emailToLower) or
     (not AccountsEntry.isStringEmail(email) and AccountsEntry.settings.usernameToLower)
      email = email.toLowerCase()

    Session.set('email', email)    
    $btns = $(event.target).find("button[type='submit']")
    Helper.disableBtns($btns)

    if Session.get('email').length is 0
      Session.set('entryError', 'Email is required')

      Helper.enableBtns($btns)
      return

    Accounts.forgotPassword({
      email: Session.get('email')
      }, (error)->
        if error
          Session.set('entryError', error.reason)
        else
          Router.go AccountsEntry.settings.resetPasswordSuccessRoute

        Helper.enableBtns($btns)
    )

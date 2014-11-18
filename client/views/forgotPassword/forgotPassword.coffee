AccountsEntry.entryForgotPasswordHelpers =
  error: -> t9n(Session.get('entryError'))

  logo: ->
    AccountsEntry.settings.logo

AccountsEntry.entryForgotPasswordEvents =
  'submit #forgotPassword': (event) ->
    event.preventDefault()
    Session.set('email', $('input[name="forgottenEmail"]').val())

    if Session.get('email').length is 0
      Session.set('entryError', 'Email is required')
      return

    Accounts.forgotPassword({email: Session.get('email')}, (error)->
      if error
        Session.set('entryError', error.reason)
      else
        Router.go AccountsEntry.settings.homeRoute
    )

Template.entryForgotPassword.helpers AccountsEntry.forgotPasswordHelpers

Template.entryForgotPassword.events AccountsEntry.forgotPasswordEvents

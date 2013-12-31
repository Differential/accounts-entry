Template.entryForgotPassword.helpers share.templateHelpers

Template.entryForgotPassword.events
  'submit #forgotPassword': (event) ->
    event.preventDefault()
    Session.set('email', $('input[type="email"]').val())

    if Session.get('email').length is 0
      share.setError i18n('error.emailRequired')
      return

    Accounts.forgotPassword({
      email: Session.get('email')
      }, (error)->
        if error
          share.setError error.reason || i18n('error.unknown')
        else
          Router.go AccountsEntry.settings.homeRoute
    )

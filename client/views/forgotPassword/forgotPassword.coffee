Template.entryForgotPassword.helpers
  error: -> t9n(Session.get('entryError'))

  logo: ->
    AccountsEntry.settings.logo

Template.entryForgotPassword.events
  'submit #forgotPassword': (event) ->
    event.preventDefault()
    Session.set('email', $('input[name="forgottenEmail"]').val())

    if Session.get('email').length is 0
      Session.set('entryError', 'Email is required')
      return

    Session.set 'talkingToServer', true
    Accounts.forgotPassword({
      email: Session.get('email')
      }, (error)->
        Session.set 'talkingToServer', false
        if error
          Session.set('entryError', error.reason)
        else
          Router.go AccountsEntry.settings.homeRoute
    )

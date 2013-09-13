Template.differentialForgotPassword.helpers
  error: -> Session.get('error')

Template.differentialForgotPassword.events
  'submit #forgotPassword': (event) ->
    event.preventDefault()
    Session.set('email', $('input[type="email"]').val())

    if Session.get('email').length is 0
      Session.set('error', 'Email is required')
      return

    Accounts.forgotPassword({
      email: Session.get('email')
      }, (error)->
        if error
          Session.set('error', error.reason)
        else
          Router.go('/')
    )

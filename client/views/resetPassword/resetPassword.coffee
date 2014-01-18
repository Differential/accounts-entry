Template.entryResetPassword.helpers
  error: -> Session.get('entryError')

  logo: ->
    AccountsEntry.settings.logo

Template.entryResetPassword.events

  'submit #resetPassword': (event) ->
    event.preventDefault()
    password = $('input[type="password"]').val()
    Accounts.resetPassword Session.get('resetToken'), password, (error) ->
      if error
        Session.set('entryError', (error.reason || "Unknown error"))
      else
        Session.set('resetToken', null)
        Router.go AccountsEntry.settings.dashboardRoute

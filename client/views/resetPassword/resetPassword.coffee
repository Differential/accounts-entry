Template[AccountsEntry.settings.resetPasswordTemplate].helpers
  error: -> Session.get('entryError')

  logo: ->
    AccountsEntry.settings.logo

Template[AccountsEntry.settings.resetPasswordTemplate].events

  'submit #resetPassword': (event) ->
    event.preventDefault()
    password = $('input[type="password"]').val()
    Accounts.resetPassword Session.get('resetToken'), password, (error) ->
      if error
        Session.set('entryError', (error.reason || "Unknown error"))
      else
        Session.set('resetToken', null)
        Router.go AccountsEntry.settings.dashboardRoute

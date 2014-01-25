Template.entryResetPassword.helpers share.templateHelpers

Template.entryResetPassword.events
  'submit #resetPassword': (event) ->
    event.preventDefault()
    password = $('input[type="password"]').val()
    Accounts.resetPassword Session.get('resetToken'), password, (error) ->
      if error
        share.setError error.reason || i18n('error.unknown')
      else
        Session.set('resetToken', null)
        Router.go AccountsEntry.settings.dashboardRoute

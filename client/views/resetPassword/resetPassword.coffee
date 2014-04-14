Template.entryResetPassword.helpers
  error: -> Session.get('entryError')

  logo: ->
    AccountsEntry.settings.logo

Template.entryResetPassword.events

  'submit #resetPassword': (event) ->
    event.preventDefault()
    password = $('input[type="password"]').val()

    passwordErrors = do (password)->
      errMsg = []
      msg = false
      if password.length < 7
        errMsg.push i18n("error.minChar")
      if password.search(/[a-z]/i) < 0
        errMsg.push i18n("error.pwOneLetter")
      if password.search(/[0-9]/) < 0
        errMsg.push i18n("error.pwOneDigit")

      if errMsg.length > 0
        msg = ""
        errMsg.forEach (e) ->
          msg = msg.concat "#{e}\r\n"

        Session.set 'entryError', msg
        return true

      return false

    if passwordErrors then return

    Accounts.resetPassword Session.get('resetToken'), password, (error) ->
      if error
        Session.set('entryError', (error.reason || "Unknown error"))
      else
        Session.set('resetToken', null)
        Router.go AccountsEntry.settings.dashboardRoute

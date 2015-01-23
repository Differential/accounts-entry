Template.entryEnrollAccount.helpers
  error: -> Session.get('entryError')

  logo: ->
    AccountsEntry.settings.logo

Template.entryEnrollAccount.events

  'submit #setPassword': (event) ->
    event.preventDefault()
    password = $('input[type="password"]').val()

    passwordErrors = do (password)->
      errMsg = []
      msg = false
      if password.length < 7
        errMsg.push t9n("error.minChar")
      if password.search(/[a-z]/i) < 0
        errMsg.push t9n("error.pwOneLetter")
      if password.search(/[0-9]/) < 0
        errMsg.push t9n("error.pwOneDigit")

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

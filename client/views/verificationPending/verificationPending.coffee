Template.entryVerificationPending.helpers
  error: -> t9n(Session.get('entryError'))

  logo: ->
    AccountsEntry.settings.logo


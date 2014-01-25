# per http://docs.meteor.com/#coffeescript, use 'share' for package scoped coffee vars...
#
share.flashId = 'accountsEntry'

share.flashOptions = ->
  id: @flashId
  autoHide: AccountsEntry.settings.flashAutoHide
  hideDelay: AccountsEntry.settings.flashHideDelay

share.setError = (msg) ->
  #console.log "set-error: msg=%s, options=%o", msg, @flashOptions()
  FlashMessages.sendError msg, @flashOptions()

share.loginServices = ->
  Accounts.oauth?.serviceNames?() || {}

share.otherLoginServices = ->
  @loginServices().length > 0

# template helpers localized to this package (avoid polluting global handlebars namespace)
#
share.templateHelpers =
  forbidClientAccountCreation: ->
    #console.log "forbid-client-account-creation: #{Accounts._options.forbidClientAccountCreation}"
    Accounts._options.forbidClientAccountCreation

  capitalize: (str) ->
    str.charAt(0).toUpperCase() + str.slice(1)

  showSignupCode: ->
    AccountsEntry.settings.showSignupCode is true

  otherLoginServices: ->
    share.otherLoginServices()

  loginServices: ->
    share.loginServices()
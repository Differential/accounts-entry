
Template.entrySocial.helpers

  buttonText: ->
    Session.get('buttonText')

  unconfigured: ->
    Accounts.loginServiceConfiguration.find({service: @toString()}).fetch().length is 0

  google: ->
    if @[0] == 'g' && @[1] == 'o'
      true

Template.entrySocial.events

  'click .btn': (event)->
    event.preventDefault()
    serviceName = $(event.target).attr('id').split('-')[1]
    callback = (err) ->
      if (!err)
        Router.go AccountsEntry.settings.dashboardRoute
      else if (err instanceof Accounts.LoginCancelledError)
        # do nothing
      else if (err instanceof ServiceConfiguration.ConfigError)
        Accounts._loginButtonsSession.configureService(serviceName)
      else
        Accounts._loginButtonsSession.errorMessage(err.reason || i18n("error.unknown"))
    loginWithService = Meteor["loginWith" + capitalize(serviceName)]
    options = {}

    if (Accounts.ui._options.requestPermissions[serviceName])
      options.requestPermissions = Accounts.ui._options.requestPermissions[serviceName]

    if (Accounts.ui._options.requestOfflineToken[serviceName])
      options.requestOfflineToken = Accounts.ui._options.requestOfflineToken[serviceName]

    loginWithService(options, callback)

capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

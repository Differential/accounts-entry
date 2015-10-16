
Template.entrySocial.helpers

  buttonText: ->
    buttonText = Session.get('buttonText')
    if buttonText == 'up'
      t9n 'signUp'
    else
      t9n 'signIn'

  unconfigured: ->
    ServiceConfiguration.configurations.find({service: @toString()}).fetch().length is 0

  google: ->
    if @[0] == 'g' && @[1] == 'o'
      true

  icon: ->
    switch @.toString()
      when 'google' then 'google-plus'
      when 'meteor-developer' then 'rocket'
      else @

Template.entrySocial.events

  'click .btn': (event)->
    event.preventDefault()
    serviceName = $(event.target).attr('id').replace 'entry-', ''
    callback = (err) ->
      Session.set 'talkingToServer', false
      if (!err)
        if Session.get('fromWhere')
          Router.go Session.get('fromWhere')
          Session.set('fromWhere', undefined)
        else
          Router.go AccountsEntry.settings.dashboardRoute
      else if (err instanceof Accounts.LoginCancelledError)
        # do nothing
      else if (err instanceof ServiceConfiguration.ConfigError)
        Accounts._loginButtonsSession.configureService(serviceName)
      else
        Accounts._loginButtonsSession.errorMessage(err.reason || t9n("error.unknown"))
    if serviceName is 'meteor-developer'
      loginWithService = Meteor["loginWithMeteorDeveloperAccount"]
    else
      loginWithService = Meteor["loginWith" + capitalize(serviceName)]
    options = {}

    if (Accounts.ui._options.requestPermissions[serviceName])
      options.requestPermissions = Accounts.ui._options.requestPermissions[serviceName]

    if (Accounts.ui._options.requestOfflineToken and Accounts.ui._options.requestOfflineToken[serviceName])
      options.requestOfflineToken = Accounts.ui._options.requestOfflineToken[serviceName]
    Session.set 'talkingToServer', true
    loginWithService(options, callback)

capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

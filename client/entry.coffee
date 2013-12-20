AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: '/home'
    dashboardRoute: '/dashboard'

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)

    if appConfig.signUpTemplate
      Router.routes = _.reject Router.routes, (e, i) ->
        e.name is 'entrySignUp'

      Router.map ->
        @route 'signUp',
          path: 'sign-up',
          template: appConfig.signUpTemplate

  templateHelpers:
    error: ->
      Session.get('entryError')

    logo: ->
      #Meteor.call('entryLogo')
      AccountsEntry.settings.logo

    isForbidClientAccountCreation: ->
      #console.log "is-forbid-client-account-creation: #{Accounts._options.forbidClientAccountCreation}"
      Accounts._options.forbidClientAccountCreation

@AccountsEntry = AccountsEntry

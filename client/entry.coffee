AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: '/home'
    dashboardRoute: '/dashboard'
    passwordSignupFields: 'EMAIL_ONLY'
    flashAutoHide: true
    flashHideDelay: 5000
    language: 'en'

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)
    #console.log "accounts-entry.config: after: config=%o, settings=%o", appConfig, @settings

    if appConfig.language
      i18n.setLanguage appConfig.language

    if appConfig.signUpTemplate
      Router.routes = _.reject Router.routes, (e, i) ->
        e.name is 'entrySignUp'
      # this will blow away before hook, likely not desired effect...!
      Router.map ->
        @route 'signUp',
          path: 'sign-up',
          template: appConfig.signUpTemplate

i18n.setDefaultLanguage AccountsEntry.settings.language
i18n.setLanguage AccountsEntry.settings.language

@AccountsEntry = AccountsEntry

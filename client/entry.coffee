AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: '/home'
    dashboardRoute: '/dashboard'
    passwordSignupFields: 'EMAIL_ONLY'

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)

    i18n.setDefaultLanguage "en"
    if appConfig.language
      i18n.setLanguage appConfig.language

    if appConfig.signUpTemplate
      Router.routes = _.reject Router.routes, (e, i) ->
        e.name is 'entrySignUp'

      Router.map ->
        @route 'signUp',
          path: 'sign-up',
          template: appConfig.signUpTemplate

@AccountsEntry = AccountsEntry

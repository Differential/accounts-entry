AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: '/home'
    dashboardRoute: '/dashboard'
    passwordSignupFields: 'EMAIL_ONLY'
    emailToLower: true
    usernameToLower: false
    entrySignUp: '/sign-up'
    extraSignUpFields: []
    showOtherLoginServices: true

  isStringEmail: (email) ->
    emailPattern = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i
    if email.match emailPattern then true else false

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)

    T9n.defaultLanguage = "en"
    if appConfig.language
      T9n.language = appConfig.language


    if appConfig.signInTemplate
      signInRoute = Router.routes['entrySignIn']
      signInRoute.options.template = appConfig.signInTemplate
    if appConfig.signUpTemplate
      signUpRoute = Router.routes['entrySignUp']
      signUpRoute.options.template = appConfig.signUpTemplate
    if appConfig.forgotPasswordTemplate
      forgotPasswordRoute = Router.routes['entryForgotPassword']
      forgotPasswordRoute.options.template = appConfig.forgotPasswordTemplate
    if appConfig.resetPasswordTemplate
      resetPasswordRoute = Router.routes['entryResetPassword']
      resetPasswordRoute.options.template = appConfig.resetPasswordTemplate

  signInRequired: (router, extraCondition) ->
    extraCondition ?= true
    unless Meteor.loggingIn()
      if Meteor.user() and extraCondition
        router.next()
      else
        Session.set('fromWhere', router.url)
        Router.go('/sign-in')
        Session.set('entryError', t9n('error.signInRequired'))

@AccountsEntry = AccountsEntry


class @T9NHelper

  @translate: (code) ->
    T9n.get code, "error.accounts"

  @accountsError: (err) ->
    Session.set 'entryError', @translate err.reason

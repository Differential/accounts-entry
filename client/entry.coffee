AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: '/home'
    dashboardRoute: '/dashboard'
    passwordSignupFields: 'EMAIL_ONLY'
    signInTemplate: 'entrySignIn'
    signUpTemplate: 'entrySignUp'
    forgotPasswordTemplate: 'entryForgotPassword'
    signOutTemplate: 'entrySignOut'
    resetPasswordTemplate: 'entryResetPassword'

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)

    i18n.setDefaultLanguage "en"
    if appConfig.language
      i18n.setLanguage appConfig.language

  signInRequired: (router, extraCondition) ->
    extraCondition ?= true
    unless Meteor.user() and extraCondition
      Session.set('fromWhere', router.path)
      Router.go('/sign-in')
      Session.set('entryError', i18n('error.signInRequired'))
      router.stop()

@AccountsEntry = AccountsEntry


class @T9NHelper

  @translate: (code) ->
#    console.log "translate: #{code}"
    T9n.get code, "error.accounts"

  @accountsError: (err) ->
    Session.set 'entryError', @translate err.reason

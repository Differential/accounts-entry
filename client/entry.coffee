AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: '/'
    dashboardRoute: '/dashboard'
    passwordSignupFields: 'EMAIL_ONLY'
    emailToLower: true
    usernameToLower: false
    entrySignUp: '/sign-up'
    extraSignUpFields: []
    showOtherLoginServices: true
    fluidLayout: false
    useContainer: true
    signInAfterRegistration: true
    emailVerificationPendingRoute: '/verification-pending'
    showSpinner: true
    spinnerOptions: { color: "#000", top: "80%" }

  isStringEmail: (email) ->
    emailPattern = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i
    if email.match emailPattern then true else false

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)

    T9n.defaultLanguage = "en"
    if appConfig.language
      T9n.language = appConfig.language

    if appConfig.signUpTemplate
      signUpRoute = Router.routes['entrySignUp']
      signUpRoute.options.template = appConfig.signUpTemplate

@AccountsEntry = AccountsEntry

AccountsEntrySignInRequired = (context, redirect) ->
 unless Meteor.loggingIn()
   unless Meteor.user()
     Session.set('fromWhere', context.path)
     redirect('/sign-in')
     Session.set('entryError', t9n('error.signInRequired'))

class @T9NHelper

  @translate: (code) ->
    T9n.get code, "error.accounts"

  @accountsError: (err) ->
    Session.set 'entryError', @translate err.reason

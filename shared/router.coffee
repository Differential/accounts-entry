overrideTemplate = (options, self) ->
  self.template = options.newTemplate

  # If the user has a custom template, and not using the helper, then
  # maintain the package Javascript so that OpenGraph tags and share
  # buttons still work.
  pkgRendered= options.oldTemplate.rendered
  userRendered = Template[self.template].rendered

  if userRendered
    Template[self.template].rendered = ->
      pkgRendered.call(self) if pkgRendered
      userRendered.call(self)
  else
    Template[self.template].rendered = pkgRendered

  Template[self.template].events options.oldEvents
  Template[self.template].helpers options.oldHelpers

Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')
      @next()
    onRun: ->
      if Meteor.userId()
        Router.go AccountsEntry.settings.dashboardRoute

      if AccountsEntry.settings.signInTemplate
        overrideTemplate
          oldTemplate: Template.entrySignIn
          oldEvents: AccountsEntry.entrySignInEvents
          oldHelpers: AccountsEntry.entrySignInHelpers
          newTemplate: AccountsEntry.settings.signInTemplate
        , this
      @next()


  @route "entrySignUp",
    path: "/sign-up"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')
      @next()
    onRun: ->
      if AccountsEntry.settings.signUpTemplate
        overrideTemplate
          oldTemplate: Template.entrySignUp
          oldEvents: AccountsEntry.entrySignUpEvents
          oldHelpers: AccountsEntry.entrySignUpHelpers
          newTemplate: AccountsEntry.settings.signUpTemplate
        , this
      @next()


  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      @next()
    onRun: ->
      if AccountsEntry.settings.forgotPasswordTemplate
        overrideTemplate
          oldTemplate: Template.entryForgotPassword
          oldEvents: AccountsEntry.entryForgotPasswordEvents
          oldHelpers: AccountsEntry.entryForgotPasswordHelpers
          newTemplate: AccountsEntry.settings.forgotPasswordTemplate
        , this
      @next()

  @route 'entrySignOut',
    path: '/sign-out'
    onBeforeAction: ()->
      Session.set('entryError', undefined)
      if AccountsEntry.settings.homeRoute
        Meteor.logout () ->
          Router.go AccountsEntry.settings.homeRoute

  @route 'entryResetPassword',
    path: 'reset-password/:resetToken'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)
      @next()
    onRun: ->
      if AccountsEntry.settings.resetPasswordTemplate
        overrideTemplate
          oldTemplate: Template.entryResetPassword
          oldEvents: AccountsEntry.entryResetPasswordEvents
          oldHelpers: AccountsEntry.entryResetPasswordHelpers
          newTemplate: AccountsEntry.settings.resetPasswordTemplate
        , this
      @next()

# Get all the accounts-entry routes one time
exclusions = []
_.each Router.routes, (route)->
  exclusions.push route.name
# Change the fromWhere session variable when you leave a path
Router.onStop ->
  # If the route is an entry route, no need to save it
  if (!_.contains(exclusions, Router.current().route.name))
    Session.set('fromWhere', Router.current().path)

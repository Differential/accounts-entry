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
        @template = AccountsEntry.settings.signInTemplate

        # If the user has a custom template, and not using the helper, then
        # maintain the package Javascript so that OpenGraph tags and share
        # buttons still work.
        pkgRendered= Template.entrySignIn.rendered
        userRendered = Template[@template].rendered

        if userRendered
          Template[@template].rendered = ->
            pkgRendered.call(@)
            userRendered.call(@)
        else
          Template[@template].rendered = pkgRendered

        Template[@template].events(AccountsEntry.entrySignInEvents)
        Template[@template].helpers(AccountsEntry.entrySignInHelpers)
      @next()


  @route "entrySignUp",
    path: "/sign-up"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')
      @next()
    onRun: ->
      if AccountsEntry.settings.signUpTemplate
        @template = AccountsEntry.settings.signUpTemplate

        # If the user has a custom template, and not using the helper, then
        # maintain the package Javascript so that OpenGraph tags and share
        # buttons still work.
        pkgRendered= Template.entrySignUp.rendered
        userRendered = Template[@template].rendered

        if userRendered
          Template[@template].rendered = ->
            pkgRendered.call(@)
            userRendered.call(@)
        else
          Template[@template].rendered = pkgRendered

        Template[@template].events(AccountsEntry.entrySignUpEvents)
        Template[@template].helpers(AccountsEntry.entrySignUpHelpers)
      @next()


  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      @next()

  @route 'entrySignOut',
    path: '/sign-out'
    onBeforeAction: ()->
      Session.set('entryError', undefined)
      if not AccountsEntry.settings.homeRoute
        @next()
      else
        Meteor.logout () ->
          Router.go AccountsEntry.settings.homeRoute

  @route 'entryVerificationPending',
    path: '/verification-pending'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      @next()

  @route 'entryResetPassword',
    path: 'reset-password/:resetToken'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)
      @next()

  @route 'entryEnrollAccount',
    path: 'enroll-account/:resetToken'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)

# Get all the accounts-entry routes one time
exclusions = []
_.each Router.routes, (route)->
  exclusions.push route.getName()
# Change the fromWhere session variable when you leave a path
Router.onStop ->
  # If the route is an entry route, no need to save it
  if (!_.contains(exclusions, Router.current().route?.getName()))
    Session.set('fromWhere', window.location.pathname)

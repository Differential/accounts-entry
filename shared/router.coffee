Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')
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


  @route "entrySignUp",
    path: "/sign-up"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')
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


  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeAction: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    path: '/sign-out'
    onBeforeAction: (pause)->
      Session.set('entryError', undefined)
      if AccountsEntry.settings.homeRoute
        Meteor.logout () ->
          Router.go AccountsEntry.settings.homeRoute
      pause()

  @route 'entryResetPassword',
    path: 'reset-password/:resetToken'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)

# Get all the accounts-entry routes one time
exclusions = [];
_.each Router.routes, (route)->
  exclusions.push route.name
# Change the fromWhere session variable when you leave a path
Router.onStop ->
  # If the route is an entry route, no need to save it
  if (Meteor.isClient && !_.contains(exclusions, Router.current().route.name))
    Session.set('fromWhere', Router.current().path)

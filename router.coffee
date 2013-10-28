Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeRun: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')
      Deps.autorun ->
        if Session.get('entrySettings') and Meteor.userId()?
          Router.go Session.get('entrySettings').dashboardRoute

  @route "entrySignUp",
    path: "/sign-up"
    onBeforeRun: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')
      Deps.autorun ->
        if Session.get('entrySettings') and Meteor.userId()?
          Router.go Session.get('entrySettings').dashboardRoute

  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeRun: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    path: '/sign-out'
    before: ->
      if AccountsEntry.settings.homeRoute
        Meteor.logout()
        Router.go AccountsEntry.settings.homeRoute
      @stop()

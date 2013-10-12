Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeRun: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    path: "/sign-up"
    onBeforeRun: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeRun: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    path: '/sign-out'
    before: ->
      if Session.get('entrySettings').homeRoute
        Meteor.logout()
        Router.go Session.get('entrySettings').homeRoute
      @stop()

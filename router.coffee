Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeRun: ->
      Session.set('error', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    path: "/sign-up"
    onBeforeRun: ->
      Session.set('error', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeRun: ->
      Session.set('error', undefined)

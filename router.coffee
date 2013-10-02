Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeRun: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUpForm",
    path: "/sign-up"
    onBeforeRun: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeRun: ->
      Session.set('entryError', undefined)

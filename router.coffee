Router.map ->

  @route "differentialSignIn",
    path: "/sign-in"
    onBeforeRun: ->
      Session.set('error', undefined)
      Session.set('buttonText', 'in')

  @route "differentialSignUp",
    path: "/sign-up"
    onBeforeRun: ->
      Session.set('error', undefined)
      Session.set('buttonText', 'up')

  @route "differentialForgotPassword",
    path: "/forgot-password"
    onBeforeRun: ->
      Session.set('error', undefined)
  

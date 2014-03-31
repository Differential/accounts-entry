Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    path: "/sign-up"
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    path: "/forgot-password"
    onBeforeAction: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    path: '/sign-out'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      if AccountsEntry.settings.homeRoute
        Meteor.logout () ->
          Router.go AccountsEntry.settings.homeRoute
      @stop()

  @route 'entryResetPassword',
    path: 'reset-password/:resetToken'
    onBeforeAction: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)

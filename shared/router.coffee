settings = AccountsEntry && AccountsEntry.settings || {}
Router.map ->

  @route "entrySignIn",
    template: settings.signInTemplate || 'entrySignIn'
    path: "/sign-in"
    before: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    template: settings.signUpTemplate || 'entrySignUp'
    path: "/sign-up"
    before: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    template: settings.forgotPasswordTemplate || 'entryForgotPassword'
    path: "/forgot-password"
    before: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    template: settings.signOutTemplate || 'entrySignOut'
    path: '/sign-out'
    before: ->
      Session.set('entryError', undefined)
      if AccountsEntry.settings.homeRoute
        Meteor.logout () ->
          Router.go settings.homeRoute
      @stop()

  @route 'entryResetPassword',
    template: settings.resetPasswordTemplate || 'entryResetPassword'
    path: 'reset-password/:resetToken'
    before: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)

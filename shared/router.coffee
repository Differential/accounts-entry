Router.map ->

  @route "entrySignIn",
    template: AccountsEntry.settings.signInTemplate
    path: "/sign-in"
    before: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    template: AccountsEntry.settings.signUpTemplate
    path: "/sign-up"
    before: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    template: AccountsEntry.settings.forgotPasswordTemplate
    path: "/forgot-password"
    before: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    template: AccountsEntry.settings.signOutTemplate
    path: '/sign-out'
    before: ->
      Session.set('entryError', undefined)
      if AccountsEntry.settings.homeRoute
        Meteor.logout () ->
          Router.go AccountsEntry.settings.homeRoute
      @stop()

  @route 'entryResetPassword',
    template: AccountsEntry.settings.resetPasswordTemplate
    path: 'reset-password/:resetToken'
    before: ->
      Session.set('entryError', undefined)
      Session.set('resetToken', @params.resetToken)

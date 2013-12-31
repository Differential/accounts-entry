# this should be moved client side as their are no server side routes...
#
Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    before: ->
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    path: "/sign-up"
    before: ->
      if Accounts._options.forbidClientAccountCreation
        share.setError i18n('error.signupForbidden')
        this.redirect 'entrySignIn'
      else
        Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    path: "/forgot-password"

  @route 'entrySignOut',
    path: '/sign-out'
    before: ->
      if AccountsEntry.settings.homeRoute
        Meteor.logout()
        Router.go AccountsEntry.settings.homeRoute
      @stop()

  @route 'entryResetPassword',
    path: 'reset-password/:resetToken'
    before: ->
      Session.set('resetToken', @params.resetToken)

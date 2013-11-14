Router.map ->

  @route "entrySignIn",
    path: "/sign-in"
    before: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'in')

  @route "entrySignUp",
    path: "/sign-up"
    before: ->
      Session.set('entryError', undefined)
      Session.set('buttonText', 'up')

  @route "entryForgotPassword",
    path: "/forgot-password"
    before: ->
      Session.set('entryError', undefined)

  @route 'entrySignOut',
    path: '/sign-out'
    before: ->
      Session.set('entryError', undefined)
      if AccountsEntry.settings.homeRoute
        Meteor.logout()
        Router.go AccountsEntry.settings.homeRoute
      @stop()

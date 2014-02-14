Template.entrySignIn.helpers
  emailInputType: ->
    if AccountsEntry.settings.passwordSignupFields is 'EMAIL_ONLY'
      'email'
    else
      'string'

  emailPlaceholder: ->
    fields = AccountsEntry.settings.passwordSignupFields

    if _.contains([
      'USERNAME_AND_EMAIL'
      'USERNAME_AND_OPTIONAL_EMAIL'
      ], fields)
      return i18n("usernameOrEmail")

    return i18n("email")

  logo: ->
    AccountsEntry.settings.logo

Template.entrySignIn.events
  'submit #signIn': (event) ->
    event.preventDefault()
    Session.set('email', $('input[name="email"]').val())
    Session.set('password', $('input[name="password"]').val())

    Meteor.loginWithPassword(Session.get('email'), Session.get('password'), (error)->
      Session.set('password', undefined)
      if error
        Session.set('entryError', error.reason)
      else if Session.get('fromWhere')
        Router.go Session.get('fromWhere')
      else
        Router.go AccountsEntry.settings.dashboardRoute
    )

AccountsEntry.entrySignInHelpers = {
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
      return t9n("usernameOrEmail")
    else if fields == "USERNAME_ONLY"
      return t9n("username")

    return t9n("email")

  logo: ->
    AccountsEntry.settings.logo

  isUsernameOnly: ->
    return AccountsEntry.settings.passwordSignupFields == 'USERNAME_ONLY'

}

AccountsEntry.entrySignInEvents = {
  'submit #signIn': (event) ->
    event.preventDefault()
    Session.set("entryError", undefined)

    email = $('#loginEmail').val();
    if (AccountsEntry.isStringEmail(email) and AccountsEntry.settings.emailToLower) or
     (not AccountsEntry.isStringEmail(email) and AccountsEntry.settings.usernameToLower)
      email = email.toLowerCase()

    Session.set('email', email)
    Session.set('password', $('input[name="password"]').val())
    Session.set 'talkingToServer', true

    if _.isEmpty(email)
      Session.set("entryError", "Please input a value for your email.")
      return false
    if _.isEmpty(Session.get('password'))
      Session.set("entryError", "Please input a value for your password.")
      return false

    Meteor.loginWithPassword(Session.get('email'), Session.get('password'), (error)->
      Session.set('password', undefined)
      Session.set 'talkingToServer', false
      if error
        T9NHelper.accountsError error
      else if Session.get('fromWhere')
        Router.go Session.get('fromWhere')
        Session.set('fromWhere', undefined)
      else if Roles.userIsInRole(Meteor.userId(), ['admin','warden'])
        Router.go AccountsEntry.settings.adminRoute
      else if Roles.userIsInRole(Meteor.userId(), ['provider'])
        Router.go AccountsEntry.settings.providerRoute
      else if Roles.userIsInRole(Meteor.userId(), ['sales'])
        Router.go AccountsEntry.settings.salesRoute
      else
        Router.go AccountsEntry.settings.dashboardRoute
    )
}

Template.entrySignIn.helpers(AccountsEntry.entrySignInHelpers)

Template.entrySignIn.events(AccountsEntry.entrySignInEvents)

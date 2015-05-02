Meteor.startup ->
  Accounts.urls.resetPassword = (token) ->
    Meteor.absoluteUrl('reset-password/' + token)

  Accounts.urls.enrollAccount = (token) ->
    Meteor.absoluteUrl('enroll-account/' + token)

  AccountsEntry =
    settings: {}

    config: (appConfig) ->
      @settings = _.extend(@settings, appConfig)

  @AccountsEntry = AccountsEntry

  Meteor.methods
    entryValidateSignupCode: (signupCode) ->
      check signupCode, Match.OneOf(String, null, undefined)
      not AccountsEntry.settings.signupCode or signupCode is AccountsEntry.settings.signupCode

    entryCreateUser: (user) ->
      check user, Object
      profile = AccountsEntry.settings.defaultProfile || {}
      user.profile = _.extend(profile, user.profile)
      userId = Accounts.createUser(user)
      Accounts.setPassword(userId, user.password);

      if(user.roles && Meteor.roles)
        Roles.addUsersToRoles(userId, user.roles)

      if (user.email && Accounts._options.sendVerificationEmail)
        Accounts.sendVerificationEmail(userId, user.email)

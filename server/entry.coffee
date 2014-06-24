Meteor.startup ->
  Accounts.urls.resetPassword = (token) ->
    Meteor.absoluteUrl('reset-password/' + token)

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
      if user.username
        Accounts.createUser
          username: user.username,
          email: user.email,
          password: user.password,
          profile: _.extend(profile, user.profile)
      else
        Accounts.createUser
          email: user.email
          password: user.password
          profile: _.extend(profile, user.profile)

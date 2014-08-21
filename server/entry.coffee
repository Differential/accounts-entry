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
      # both username & email provided
      if user.username && user.email
        userId = Accounts.createUser
          username: user.username,
          email: user.email,
          password: user.password,
          profile: _.extend(profile, user.profile)
      # only username provided
      else if user.username && !user.email
        userId = Accounts.createUser
          username: user.username,
          password: user.password,
          profile: _.extend(profile, user.profile)
      # only email provided
      else if user.email && !user.username
        userId = Accounts.createUser
          email: user.email
          password: user.password
          profile: _.extend(profile, user.profile)
      if (user.email && Accounts._options.sendVerificationEmail)
        Accounts.sendVerificationEmail(userId, user.email)

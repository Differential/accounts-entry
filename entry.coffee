Meteor.startup ->
  AccountsEntry =
    settings: {}

    config: (appConfig) ->
      @settings = _.extend(@settings, appConfig)

  @AccountsEntry = AccountsEntry

  Meteor.methods
    entryValidateSignupCode: (signupCode) ->
      not AccountsEntry.settings.showSignupCode or signupCode is AccountsEntry.settings.signupCode

    accountsCreateUser: (username, email, password) ->
      if Accounts._options['forbidClientAccountCreation']
        throw new Meteor.Error 403, "New account creation is forbidden"

      if username
        Accounts.createUser
          username: username,
          email: email,
          password: password,
          profile: AccountsEntry.settings.defaultProfile || {}
      else
        Accounts.createUser
          email: email
          password: password
          profile: AccountsEntry.settings.defaultProfile || {}

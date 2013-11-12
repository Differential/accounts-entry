Meteor.startup ->
  AccountsEntry =
    settings: {}

    config: (appConfig) ->
      @settings = _.extend(@settings, appConfig)

  @AccountsEntry = AccountsEntry

  Meteor.methods
    entryValidateSignupCode: (signupCode) ->
      not AccountsEntry.settings.showSignupCode or signupCode is AccountsEntry.settings.signupCode

Accounts.onCreateUser (options,user) ->
  user.profile = AccountsEntry.settings.defaultProfile || {}
  return user

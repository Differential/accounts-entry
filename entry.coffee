Meteor.startup ->
  AccountsEntry =
    settings:
      wrapLinks: true
      homeRoute: 'home'
      dashboardRoute: 'dashboard'
      defaultProfile: {}

    config: (appConfig) ->
      @settings = _.extend(@settings, appConfig)

  @AccountsEntry = AccountsEntry

  Meteor.methods
    entrySettings: ->
      logo: AccountsEntry.settings.logo
      profileRoute: AccountsEntry.settings.profileRoute
      homeRoute: AccountsEntry.settings.homeRoute
      dashboardRoute: AccountsEntry.settings.dashboardRoute
      wrapLinks: AccountsEntry.settings.wrapLinks
      privacyUrl: AccountsEntry.settings.privacyUrl
      termsUrl: AccountsEntry.settings.termsUrl
      showSignupCode: AccountsEntry.settings.signupCode?

    entryValidateSignupCode: (signupCode) ->
      not AccountsEntry.settings.showSignupCode or signupCode is AccountsEntry.settings.signupCode

    accountsCreateUser: (username, email, password) ->
      if username
        Accounts.createUser({
          username: username,
          email: email,
          password: password,
          profile: AccountsEntry.settings.defaultProfile || {}
        })
      else
        Accounts.createUser({
          email: email,
          password: password,
          profile: AccountsEntry.settings.defaultProfile || {}
        })


Meteor.startup ->
  Accounts.urls.resetPassword = (token) ->
    Meteor.absoluteUrl('reset-password/' + token)

  Accounts.onCreateUser (options, user) ->
    if user.services
      service = _.keys(user.services)[0]
      email = user.services[service].email
      user.profile = {}
      user.profile[service] = true

      # can't merge user accounts by email if service doesn't provide email
      unless email
        return user

      user.emails = [address: email]

      # see if any existing user has this email address, otherwise create new
      existingUser = Meteor.users.findOne {"emails.address": email}
      return user unless existingUser

      # precaution, these will exist from accounts-password if used
      unless existingUser.services
        existingUser.services = resume:
          loginTokens: []
      unless existingUser.services.resume
        existingUser.services.resume = loginTokens: []

      # copy across new service info
      existingUser.services[service] = user.services[service]
      existingUser.services.resume.loginTokens.push user.services.resume.loginTokens[0]
      existingUser.profile[service] = true

      # even worse hackery
      Meteor.users.remove _id: existingUser._id # remove existing record
      existingUser # record is re-inserted
    else
      if options.profile
        user.profile = options.profile
      else
        user.profile = {}
      user

  AccountsEntry =
    settings: {}

    config: (appConfig) ->
      @settings = _.extend(@settings, appConfig)

  @AccountsEntry = AccountsEntry

  Meteor.methods
    entryValidateSignupCode: (signupCode) ->
      not AccountsEntry.settings.signupCode or signupCode is AccountsEntry.settings.signupCode

    accountsCreateUser: (username, email, password) ->
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

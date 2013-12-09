AccountsEntry =
  settings:
    wrapLinks: true
    homeRoute: 'home'
    dashboardRoute: 'dashboard'

  config: (appConfig) ->
    @settings = _.extend(@settings, appConfig)

@AccountsEntry = AccountsEntry

Handlebars.registerHelper 'capitalize', (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)

Handlebars.registerHelper 'signupClass', ->
  if Accounts.oauth && Accounts.oauth.serviceNames().length > 0
    "collapse"

Handlebars.registerHelper 'otherLoginServices', ->
  Accounts.oauth &&
  Accounts.oauth.serviceNames().length > 0

Handlebars.registerHelper 'loginServices', ->
  Accounts.oauth.serviceNames()

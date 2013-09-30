
Template.accountEntryWidget.helpers
  inline: ->
      AccountsEntry.config.inline

  signedInAs: ->
    Meteor.user().username ?
    (Meteor.user().profile?.name ?
    (Meteor.user().emails[0]?.address ? "Logged In"))

  profileUrl: ->
    return false unless AccountsEntry.config.profileRoute
    Router.path(AccountsEntry.config.profileRoute)

  wrapLinks: ->
    AccountsEntry.config.wrapLinks

  showUserName: ->
    AccountsEntry.config.showUserName

Template.accountEntryWidget.events
  "click .sign-out": (event) ->
    event.preventDefault()
    if AccountsEntry.config.homeRoute
      Meteor.logout()
      Router.go AccountsEntry.config.homeRoute

  "click button.loginputBtn": (e, t)->
      e.preventDefault()
      ##retrieve the input field value
      email = t.find('#login-email').value
      password = t.find('#login-password').value

      email = email.replace /^\s*|\s*$/g, ""

      Meteor.loginWithPassword email, password, (err)->
          if err
              switch err.reason
                  when "User not found"
                      a = new ErrorAlert err.reason, "/sign-up", "Sign Up", true
                      Session.set 'email', email
                      Session.set 'password', password
                      Router.go "/sign-in"
                  when "Incorrect password"
                      a = new ErrorAlert err.reason, 'forgot-password', " Request password reset link for: #{email}"
                  else
                      a = new ErrorAlert err.reason
          else
              a = new SuccessAlert "Login successful."

          Alerts.insert a


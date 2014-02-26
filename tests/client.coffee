Tinytest.add "Accounts Entry - {{accountButtons}} helper", (test) ->
  html = OnscreenDiv(Meteor.render(Template.test_helper_account_buttons))
  test.notEqual html.rawHtml().indexOf("Sign In"), -1, "Account Buttons helper didn't render a sign in link."
  test.notEqual html.rawHtml().indexOf("Sign Up"), -1, "Account Buttons helper didn't render a sign up link."

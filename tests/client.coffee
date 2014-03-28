renderToDiv = (comp) ->
  div = document.createElement("DIV")
  UI.materialize comp, div
  div

Tinytest.add "Accounts Entry - {{accountButtons}} helper", (test) ->
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  debugger
  test.notEqual html.indexOf("Sign In"), -1, "Account Buttons helper didn't render a sign in link."
  test.notEqual html.indexOf("Sign Up"), -1, "Account Buttons helper didn't render a sign up link."

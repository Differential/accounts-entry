renderToDiv = (comp) ->
  div = document.createElement("DIV")
  UI.materialize comp, div
  div

Tinytest.add "Accounts Entry - {{accountButtons}} helper", (test) ->
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  test.include html, "Sign In"
  test.include html, "Sign Up"

Tinytest.add "Accounts Entry - wrapLinks setting on should wrap links in li elements", (test) ->
  AccountsEntry.settings.wrapLinks = true
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  test.include html, '<li><a href="/sign-in">Sign In</a></li>'


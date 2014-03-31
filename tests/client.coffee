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

Tinytest.add "Accounts Entry - wrapLinks setting on should not show 'or span'", (test) ->
  AccountsEntry.settings.wrapLinks = true
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  scan = html.indexOf('<span>or</span>')
  test.equal(scan, -1, "Html output includes or span but shouldn't")

Tinytest.add "Accounts Entry - wrapLinks setting off should not wrap links in li elements", (test) ->
  AccountsEntry.settings.wrapLinks = false
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  scan = html.indexOf('<li>')
  test.equal(scan, -1, "Html output shouldn't have li tags")

Tinytest.add "Accounts Entry - wrapLinks setting off should show 'or span'", (test) ->
  AccountsEntry.settings.wrapLinks = false
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  test.include html, '<span>or</span>'

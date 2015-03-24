renderToDiv = (comp) ->
  div = document.createElement("DIV")
  Blaze.render(comp,div)
  div

Tinytest.add "Accounts Entry - {{accountButtons}} helper", (test) ->
  div = renderToDiv(Template.test_helper_account_buttons)
  html = canonicalizeHtml(div.innerHTML)
  test.include html, "Sign In"
  test.include html, "Register"

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

Tinytest.add "Accounts Entry - forgot password link should not show up if username only is set", (test) ->
  AccountsEntry.settings.passwordSignupFields = "USERNAME_ONLY"
  div = renderToDiv(Template.test_helper_sign_in)
  html = canonicalizeHtml(div.innerHTML)
  scan = html.indexOf('<a href="/forgot-password">')
  test.equal(scan, -1, "Forgot password link should not show up if username only is set")

Tinytest.add "Accounts Entry - adding extra fields to the layout", (test) ->
  AccountsEntry.settings.extraSignUpFields = [{field: 'zipcode', required: true, type: 'number'}]
  Package['accounts-password'] = true
  div = renderToDiv(Template.test_helper_sign_up)
  html = canonicalizeHtml(div.innerHTML)
  test.include html, '<div class="form-group"><label for="zipcode">Zipcode</label><input class="form-control" id="zipcode" name="zipcode" required="" type="number" value=""></div>'

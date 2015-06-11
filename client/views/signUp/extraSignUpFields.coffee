Template.entryExtraSignUpFields.helpers
  extraSignUpFields: ->
    AccountsEntry.settings.extraSignUpFields

Template._entryExtraSignUpField.helpers
  isTextField: ->
    @type isnt "check_box" and @type isnt "select_box"

  isCheckbox: ->
    @type is "check_box"

  isSelectbox: ->
    @type is "select_box"



# Added by GB
Template.entryExtraSignUpFields.events
  'change select.languageCode': (evt) ->
    newLang = $(evt.target).val();
    console.log "Template.entryExtraSignUpFields.events","change languageCode", newLang
    i18n.setLanguage(newLang)
    
Template.entryExtraSignUpFields.rendered = ->
  $select = $("select.languageCode")
  if $select
    $("select.languageCode").val(i18n.getLanguage())
    
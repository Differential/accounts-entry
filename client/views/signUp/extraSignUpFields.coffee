Template.entryExtraSignUpFields.helpers
  extraSignUpFields: ->
    AccountsEntry.settings.extraSignUpFields
  useSchema: ->
  	AccountsEntry.settings.useSchema

Template._entryExtraSignUpField.helpers
  isTextField: ->
    @type isnt "check_box"

  isCheckbox: ->
    @type is "check_box"

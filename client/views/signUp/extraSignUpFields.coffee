Template.entryExtraSignUpFields.helpers
  extraSignUpFields: ->
    AccountsEntry.settings.extraSignUpFields

Template._entryExtraSignUpField.helpers
  isTextField: ->
    @type isnt "check_box"

  isCheckbox: ->
    @type is "check_box"

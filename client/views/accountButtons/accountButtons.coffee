Template.entryAccountButtons.helpers share.templateHelpers

Template.entryAccountButtons.helpers
  profileUrl: ->
    return false unless AccountsEntry.settings.profileRoute
    AccountsEntry.settings.profileRoute

  wrapLinks: ->
    AccountsEntry.settings.wrapLinks

  signedInAs: ->
    if Meteor.user().username
      Meteor.user().username
    else if Meteor.user().profile.name
      Meteor.user().profile.name
    else if Meteor.user().emails and Meteor.user().emails[0]
      Meteor.user().emails[0].address
    else
      i18n('signedIn')

Handlebars.registerHelper("accountButtons", function() {
  return new Handlebars.SafeString(Template.differentialAccountButtons());
});

Template.differentialAccountButtons.events({
  "click .differential-sign-out": function(event) {
    return event.preventDefault();
  }
}, Meteor.logout(), AccountsEntry.config.homeRoute ? Router.go(AccountsEntry.config.homeRoute) : void 0);

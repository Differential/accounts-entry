if (typeof Handlebars !== 'undefined') {
  Handlebars.registerHelper("signedInAs", function(date) {
    if (Meteor.user().username) {
      Meteor.user().username;
    } else if (Meteor.user().profile.name) {
      Meteor.user().profile.name;
    } else if (Meteor.user().emails && Meteor.user().emails[0]) {
      Meteor.user().emails[0].address;
    } else {
      "Logged In";
    }
  });
}

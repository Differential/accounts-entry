Template.differentialSignIn.helpers({
  logo: function() {
    return AccountsEntry.config.logo;
  }
});

Template.differentialSignIn.events({
  'submit #signIn': function(event) {
    event.preventDefault();
    Session.set('email', $('input[type="email"]').val());
    Session.set('password', $('input[type="password"]').val());
    return Meteor.loginWithPassword(Session.get('email'), Session.get('password'), function(error) {
      if (error) {
        return Session.set('error', error.reason);
      } else {
        return Router.go('/');
      }
    });
  }
});

Template.differentialForgotPassword.helpers({
  error: function() {
    return Session.get('error');
  }
});

Template.differentialForgotPassword.helpers({
  logo: function() {
    return AccountsEntry.config.logo;
  }
});

Template.differentialForgotPassword.events({
  'submit #forgotPassword': function(event) {
    event.preventDefault();
    Session.set('email', $('input[type="email"]').val());
    if (Session.get('email').length === 0) {
      Session.set('error', 'Email is required');
      return;
    }
    return Accounts.forgotPassword({
      email: Session.get('email')
    }, function(error) {
      if (error) {
        return Session.set('error', error.reason);
      } else {
        return Router.go('/');
      }
    });
  }
});

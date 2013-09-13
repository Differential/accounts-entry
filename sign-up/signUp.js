Handlebars.registerHelper('capitalize', function(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
});

Handlebars.registerHelper('otherLoginServices', function() {
  return Accounts.oauth && Accounts.oauth.serviceNames().length > 0;
});

Handlebars.registerHelper('loginServices', function() {
  return Accounts.oauth.serviceNames();
});

Template.differentialSignUp.helpers({
  logo: function() {
    return AccountsEntry.config.logo;
  },
  privacyUrl: function() {
    return AccountsEntry.config.privacyUrl;
  },
  termsUrl: function() {
    return AccountsEntry.config.termsUrl;
  },
  both: function() {
    return AccountsEntry.config.privacyUrl && AccountsEntry.config.termsUrl;
  },
  neither: function() {
    return !AccountsEntry.config.privacyUrl && !AccountsEntry.config.termsUrl;
  }
});

Template.differentialSignUp.events({
  'submit #signUp': function(event) {
    var email, password;
    event.preventDefault();
    email = $('input[type="email"]').val();
    password = $('input[type="password"]').val();
    if (email.length === 0) {
      Session.set('error', 'Email is required');
      return;
    }
    if (password.length === 0) {
      Session.set('error', 'Password is required');
      return;
    }
    return Accounts.createUser({
      email: email,
      password: password
    }, function(error) {
      if (error) {
        return Session.set('error', error.reason);
      } else {
        return Router.go(AccountsEntry.config.dashboardRoute);
      }
    });
  }
});

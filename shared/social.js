var capitalize = function(str) {
  return str.charAt(0).toUpperCase() + str.slice(1);
};

Template.differentialSocial.helpers({
  buttonText: function() {
    return Session.get('buttonText');
  },
  google: function() {
    if (this[0] === 'g') {
      return true;
    }
  }
});

Template.differentialSocial.events({
  'click .btn': function() {
    var callback, loginWithService, options, serviceName;
    serviceName = $(event.target).attr('id').split('-')[1];
    callback = function(err) {
      if (!err) {
        return Router.go('dashboard');
      } else if (err instanceof Accounts.LoginCancelledError) {

      } else if (err instanceof ServiceConfiguration.ConfigError) {
        return loginButtonsSession.configureService(serviceName);
      } else {
        return loginButtonsSession.errorMessage(err.reason || "Unknown error");
      }
    };
    loginWithService = Meteor["loginWith" + capitalize(serviceName)];
    options = {};
    if (Accounts.ui._options.requestPermissions[serviceName]) {
      options.requestPermissions = Accounts.ui._options.requestPermissions[serviceName];
    }
    if (Accounts.ui._options.requestOfflineToken[serviceName]) {
      options.requestOfflineToken = Accounts.ui._options.requestOfflineToken[serviceName];
    }
    loginWithService(options, callback);
    return Router.go('/');
  }
});

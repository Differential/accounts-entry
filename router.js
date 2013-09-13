Router.map(function() {
  this.route("differentialSignIn", {
    path: "/sign-in",
    onBeforeRun: function() {
      Session.set('error', void 0);
      return Session.set('buttonText', 'in');
    }
  });
  this.route("differentialSignUp", {
    path: "/sign-up",
    onBeforeRun: function() {
      Session.set('error', void 0);
      return Session.set('buttonText', 'up');
    }
  });
  return this.route("differentialForgotPassword", {
    path: "/forgot-password",
    onBeforeRun: function() {
      return Session.set('error', void 0);
    }
  });
});

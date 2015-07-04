FlowRouter.route('/sign-in', {
   name: 'entrySignIn',
   triggersEnter: [
      function(context, redirect) {
         Session.set('entryError', undefined);
         Session.set('buttonText', 'in');
      }
   ],
   action: function(params) {
      var pkgRendered, userRendered;

      if (Meteor.userId()) {
         redirect(AccountsEntry.settings.dashboardRoute);
      }
      if (AccountsEntry.settings.signInTemplate) {
         this.template = AccountsEntry.settings.signInTemplate;
         pkgRendered = Template.entrySignIn.rendered;
         userRendered = Template[this.template].rendered;
         if (userRendered) {
            Template[this.template].rendered = function() {
               pkgRendered.call(this);
               return userRendered.call(this);
            };
         } else {
            Template[this.template].rendered = pkgRendered;
         }
         Template[this.template].events(AccountsEntry.entrySignInEvents);
         Template[this.template].helpers(AccountsEntry.entrySignInHelpers);
      }
      FlowLayout.render('entrySignIn');
   }
});


FlowRouter.route('/sign-up', {
   name: 'entrySignUp',
   triggersEnter: [
      function(context, redirect) {
         Session.set('entryError', undefined);
         Session.set('buttonText', 'up');
      }
   ],
   action: function(params) {
     var pkgRendered, userRendered;
      if (AccountsEntry.settings.signUpTemplate) {
         this.template = AccountsEntry.settings.signUpTemplate;

         // If the user has a custom template, and not using the helper, then
         // maintain the package Javascript so that OpenGraph tags and share
         // buttons still work.
         pkgRendered = Template.entrySignUp.rendered;
         userRendered = Template[this.template].rendered;

         if (userRendered) {
            Template[this.template].rendered = function() {
               pkgRendered.call(this);
               return userRendered.call(this);
            };
         } else {
            Template[this.template].rendered = pkgRendered;
         }

         Template[this.template].events(AccountsEntry.entrySignUpEvents);
         Template[this.template].helpers(AccountsEntry.entrySignUpHelpers);
      }
      FlowLayout.render('entrySignUp');
   }
});

clearEntryError = function(context, redirect) {
   Session.set('entryError', undefined);
};

FlowRouter.route('/forgot-password', {
   name: 'entryForgotPassword',
   triggersEnter: [clearEntryError],
   action: function() {
      FlowLayout.render('entryForgotPassword');
   }
});

FlowRouter.route('/sign-out', {
   name: 'entrySignOut',
   triggersEnter: [
      function(context, redirect) {
         Session.set('entryError', undefined);
         if (AccountsEntry.settings.homeRoute) {
            Meteor.logout(function() {
               return FlowRouter.go(AccountsEntry.settings.homeRoute);
            });
         }
      }
   ],
   action: function() {
      FlowLayout.render('entrySignOut');
   }
});

FlowRouter.route('/verification-pending', {
   name: 'entryVerificationPending',
   triggersEnter: [clearEntryError],
   action: function() {
      FlowLayout.render('entryVerificationPending');
   }
});

FlowRouter.route('/reset-password/:resetToken', {
   name: 'entryResetPassword',
   triggersEnter: [
      function(context, redirect) {
         Session.set('entryError', undefined);
         Session.set('resetToken', this.params.resetToken);
      }
  ],
   action: function() {
      FlowLayout.render('entryResetPassword');
   }
});

FlowRouter.route('/enroll-account/:resetToken', {
   name: 'entryEnrollAccount',
   triggersEnter: [
      function(context, redirect) {
         Session.set('entryError', undefined);
         Session.set('resetToken', this.params.resetToken);
      }
  ],
   action: function() {
      FlowLayout.render('entryEnrollAccount');
   }
});

AccountsEntryRouteList = [
   'entrySignIn',
   'entrySignUp',
   'entryForgotPassword',
   'entrySignOut',
   'entryVerificationPending',
   'entryResetPassword',
   'entryEnrollAccount'
];

// set the fromWhere when you leave any path except the en
FlowRouter.triggers.exit([
      function(context) {
         Session.set('fromWhere', context.path);
      }
   ],
   { except: AccountsEntryRouteList }
);

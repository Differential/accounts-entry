Package.describe({
    summary: "Make signin and signout their own pages with routes."
});

Package.on_use(function(api) {
  api.use(['deps',
          'service-configuration',
          'accounts-base',
          'underscore',
          'templating',
          'handlebars',
          'spark',
          'session',
          'coffeescript',
          'iron-router',
          'noty',
          'parsley',
          'less'],
        'client');
  api.imply('accounts-base', ['client', 'server']);
  api.add_files([
    'entry.html',
    'entry.coffee',
    'accountEntryWidget.html',
    'accountEntryWidget.coffee',
    'router.coffee',
    'sign-in/signIn.html',
    'sign-in/signIn.coffee',
    'sign-up/signUp.html',
    'sign-up/signUp.coffee',
    'forgot-password/forgotPassword.html',
    'forgot-password/forgotPassword.coffee',
    'shared/social.html',
    'shared/social.coffee',
    'shared/error.html',
    'shared/error.coffee',
    'shared/accountButtons.html',
    'shared/accountButtons.coffee',
    'entry.less']
  , 'client');
});

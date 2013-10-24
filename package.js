Package.describe({
    summary: "Make signin and signout their own pages with routes."
});

Package.on_use(function(api) {
  api.use([
    'deps',
    'service-configuration',
    'accounts-base',
    'underscore',
    'templating',
    'handlebars',
    'spark',
    'session',
    'coffeescript',
    'less']
  , 'client');

  api.imply('accounts-base', ['client', 'server']);

  api.add_files([
    'shared/start.coffee',
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
    'entry.less',
    'helper.js']
  , 'client');

  api.use([
    'deps',
    'service-configuration',
    'accounts-password',
    'accounts-base',
    'underscore',
    'coffeescript']
  , 'server');

  api.export('AccountsEntry', ['client', 'server']);
  api.add_files('entry.coffee', 'server');

  api.use('iron-router', ['client', 'server']);
  api.add_files('router.coffee', ['client', 'server']);
});

Package.describe({
    summary: "Make signin and signout their own pages with routes."
});

Package.on_use(function(api) {
  api.use(['deps',
          'service-configuration',
          'accounts-base',
          'accounts-ui-unstyled',
          'underscore',
          'templating',
          'handlebars',
          'spark',
          'session',
          'iron-router',
          'less'],
        'client');
  api.imply('accounts-base', ['client', 'server']);
  api.add_files([
    'entry.js',
    'router.js',
    'sign-in/signIn.html',
    'sign-in/signIn.js',
    'sign-up/signUp.html',
    'sign-up/signUp.js',
    'forgot-password/forgotPassword.html',
    'forgot-password/forgotPassword.js',
    'shared/social.html',
    'shared/social.js',
    'shared/error.html',
    'shared/error.js',
    'shared/accountButtons.html',
    'shared/accountButtons.js',
    'entry.less']
  , 'client');
});

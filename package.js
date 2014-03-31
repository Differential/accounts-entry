Package.describe({
    summary: "Make signin and signout their own pages with routes."
});

Package.on_use(function(api) {

  // CLIENT
  api.use([
    'deps',
    'service-configuration',
    'accounts-base',
    'underscore',
    'templating',
    'handlebars',
    'session',
    'coffeescript',
    'less']
  , 'client');


  api.add_files([
    'client/entry.coffee',
    'client/entry.less',
    'client/helpers.coffee',
    'client/views/signIn/signIn.html',
    'client/views/signIn/signIn.coffee',
    'client/views/signUp/signUp.html',
    'client/views/signUp/signUp.coffee',
    'client/views/forgotPassword/forgotPassword.html',
    'client/views/forgotPassword/forgotPassword.coffee',
    'client/views/resetPassword/resetPassword.html',
    'client/views/resetPassword/resetPassword.coffee',
    'client/views/social/social.html',
    'client/views/social/social.coffee',
    'client/views/error/error.html',
    'client/views/error/error.coffee',
    'client/views/accountButtons/accountButtons.html',
    'client/views/accountButtons/accountButtons.coffee',
    'client/views/accountButtons/_wrapLinks.html',
    'client/i18n/english.coffee',
    'client/i18n/german.coffee',
    'client/i18n/spanish.coffee'
  ], 'client');

  // SERVER
  api.use([
    'deps',
    'service-configuration',
    'accounts-password',
    'accounts-base',
    'underscore',
    'coffeescript'
  ], 'server');

  api.add_files(['server/entry.coffee'], 'server');

  // CLIENT and SERVER
  api.imply('accounts-base', ['client', 'server']);
  api.export('AccountsEntry', ['client', 'server']);
  api.use('iron-router', ['client', 'server']);
  api.use(['just-i18n', 'accounts-t9n'], ['client', 'server']);
  api.add_files(['shared/router.coffee'], ['client', 'server']);

});

Package.on_test(function (api) {
  api.use(['tinytest',
            'handlebars',
            'test-helpers',
            'templating',
            'mongo-livedata',
            'coffeescript',
            'iron-router'])
  api.use('accounts-entry')

  api.add_files(['tests/route.coffee', 'tests/client.html', 'tests/client.coffee'], 'client')
})

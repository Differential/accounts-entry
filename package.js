Package.describe({
    summary: "Make signin and signout their own pages with routes."
});

Package.on_use(function(api) {
  api.use(['deps', 'service-configuration', 'accounts-base',
               'underscore', 'templating',
                          'handlebars', 'spark', 'session', 'coffeescript',
                          'less'], 'client');
  api.imply('accounts-base', ['client', 'server']);
  api.use('iron-router', 'client');
  api.use('accounts-ui-unstyled', 'client');
  api.add_files(['router.coffee', 'signIn.html', 'join.html',
                  'forgotPassword.html', 'social.html', 'error.html',
                  'accountButtons.html', 
                  'signIn.coffee', 'join.coffee', 'social.coffee',
                  'accountButtons.coffee',
                  'forgotPassword.coffee', 'error.coffee', 'entry.less'], 'client');
});

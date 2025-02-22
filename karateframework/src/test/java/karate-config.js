function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'staging';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
	username: 'admin',
	password: 'welcome',
	_url: 'http://localhost:9897'
	
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
	config.username = 'author';
	config.password = 'authorpassword';
  } else if (env == 'e2e') {
	config.username = 'user';
	config.password = 'userpassword';
  }else if (env == 'staging') {
	// Initialize the config for staging
	username: 'stagingadmin';
	password: 'stagngwelcome';
	_url: 'http://staging.localhost:9897'
  }else if (env == 'preprod') {
	// Initialize the config for preprod
	username: 'preprodadmin';
	password: 'preprodwelcome';
	_url: 'http://preprod.localhost:9897'
  }else if (env == 'prod') {
	// Initialize the config for prod
	username: 'prodadmin';
	password: 'prodwelcome';
	_url: 'http://localhost:9897'
  }
  
  return config;
}
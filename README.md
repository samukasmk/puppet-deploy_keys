samukasmk-deploy_keys
=====================

Puppet module to manage deploy keys, for use example in (git clone)/(vcsrepo) actions.

Goal: Store your private keys for secure deploys, avoiding unsafe ssh connections with user/password.

Example 1: Basic Usage
```puppet
class { "deploy_keys":
  key_name     => "my_deploy_key",
  source       => "puppet:///files/.../my_deploy_key",
  user         => "root"
}
```

By default your keys will be stored in "/etc/puppet/.deploy_keys/\<username\>/\<my_deploy_key\>"



Example 2: Defining different base folder in same schema
```puppet
class { "deploy_keys":
  key_name     => "my_deploy_key",
  source       => "puppet:///files/.../my_deploy_key",
  user         => "root",
  base_folder  => "/usr/share/my_keys",
}
```

Now your keys will be stored in "/usr/share/my_keys/\<username\>/\<my_deploy_key\>"


Example 3: Define the specific folder to key 
```puppet
class { "deploy_keys":
  key_name     => "my_deploy_key",
  source       => "puppet:///files/.../my_deploy_key",
  user         => "root",
  key_dest     => "/root/.ssh/id_rsa"
}
```

To the final example, your keys will be stored in "/root/.ssh/id_rsa"


Please contribute with us, creating your pull request :
```
https://github.com/samukasmk/puppet-deploy_keys.git
```

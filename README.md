samukasmk-deploy_keys
=====================

Puppet module to manage deploy keys, for use example in (git clone)/(vcsrepo) actions.

Goal: Store your private keys for secure deploys, avoiding unsafe ssh connections with user/password.


### Example 1: Basic Usage

By default your keys will be stored in schema: "/etc/puppet/.deploy_keys/\<username\>/\<my_deploy_key\>"
```puppet
class { "deploy_keys":
  key_name     => "my_deploy_key",
  source       => "puppet:///files/.../my_deploy_key",
  user         => "root"
}
```





### Example 2: Defining different base folder in same schema

If you wish, is possible store your keys in other folder, but in the same schema:

"/path/to/my/other/folder/\<username\>/\<my_deploy_key\>"
```puppet
class { "deploy_keys":
  key_name     => "my_deploy_key",
  source       => "puppet:///files/.../my_deploy_key",
  user         => "root",
  base_folder  => "/path/to/my/other/folder",
}
```




### Example 3: Define the specific folder to key 
To the final example, your keys will be stored simply in "/root/.ssh/id_rsa"
```puppet
class { "deploy_keys":
  key_name     => "my_deploy_key",
  source       => "puppet:///files/.../my_deploy_key",
  user         => "root",
  key_dest     => "/root/.ssh/id_rsa"
}
```


Please contribute with us, creating your pull request :
```
https://github.com/samukasmk/puppet-deploy_keys.git
```

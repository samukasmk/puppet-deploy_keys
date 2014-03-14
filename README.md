samukasmk-deploy_keys
=====================

Puppet module to manage deploy keys, for use example in (git clone)/(vcsrepo) actions.

Usage:
```puppet
class { "deploy_keys":
  key_name  => "my_deploy_key",
  source    => "puppet:///files/.../my_deploy_key",
  user      => "root"
}
```

Please contribute with us:
https://github.com/samukasmk/samukasmk-deploy_keys.git
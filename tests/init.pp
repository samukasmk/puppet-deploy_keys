# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
include deploy_keys

class { "deploy_keys":
  key_name     => "test_basic_usage",
  source       => "puppet:///modules/deploy_keys/key_of_test_1",
  user         => "root"
}

class { "deploy_keys":
  key_name     => "test_other_folder_same_schema",
  source       => "puppet:///modules/deploy_keys/key_of_test_2",
  user         => "root",
  base_folder  => "/usr/share/my_keys",
}

class { "deploy_keys":
  key_name     => "test_specific_path",
  source       => "puppet:///modules/deploy_keys/key_of_test_3",
  user         => "test",
  key_dest     => "/home/test/.ssh/id_rsa"
}
# == Class: deploy_keys
#
# Creates deploy_keys for users uses like git clone requirements
#
# === Parameters
#
# [key_name]
#   Description: Define the name of the key file generated
#   Required: Yes
#   Default: None
#
# [source]
#   Description: Define the file path in puppet file bucket
#   Required: Yes
#   Default: None
#
# [user]
#   Description: Define the user owner of the deploy_keys
#   Required: No
#   Default: "root"
#
# [base_folder]
#   Description: Define a base folder to all deploy keys
#   Required: No
#   Default: "/etc/puppet/.deploy_keys"
#
# === Variables
#
# [user_folder]
#   Description: The relative path of user's key folder
#
# [key_file]
#   Description: The relative path of key
#
# === Examples
#
#  class { "deploy_keys":
#    key_name  => "my_deploy_key",
#    source    => "puppet:///files/.../my_deploy_key",
#    user      => "root"
#  }
#
# === Authors
#
# Author: Samuel Maciel Sampaio (samukasmk)
#
# === Copyright
#
# Copyright 2014 - Samuel Maciel Sampaio.
#

class deploy_keys (
  $key_name,
  $source,
  $user         = "root",
  $key_dest     = undef,
  $base_folder  = "/etc/puppet/.deploy_keys",
) {

  if ($key_dest != undef) {
    $key_folder = generate('/usr/bin/dirname', $key_dest)
    $key_file   = $key_dest
  } else {
    $key_folder = "${base_folder}/${user}"
    $key_file   = "${key_folder}/${key_name}"
  }

  Exec {
    path      => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin',
    user      => 'root',
  }

  notify { "Ensuring folder and subfolders exist: ${key_folder}": }
  exec { "ensure_subfolders_exist":
    command   => "mkdir -p ${key_folder}",
  }

  notify { "Ensuring folder owner: ${key_folder}": }
  exec { "ensure_subfolders_owner":
    command   => "chown ${user}:root ${key_folder}",
    require   => Exec["ensure_subfolders_exist"]
  }

  notify { "Ensuring folder permission: ${key_folder}": }
  exec { "ensure_folders_permission":
    command   => "chmod 500 ${key_folder}",
    require   => Exec["ensure_subfolders_exist"]
  }  

  notify { "Ensuring deploy_key file: ${key_file}": }
  file { $key_file:
    ensure    => present,
    owner     => $user,
    group     => 'root',
    mode      => '400',    
    source    => $source,
    require   => Exec["ensure_subfolders_exist"]
  }

}

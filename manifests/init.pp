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
# [key_path]
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
  $user         = $deploy_keys::params::user,
  $base_folder  = $deploy_keys::params::base_folder,
  $user_folder  = $deploy_keys::params::user_folder,  
) inherits deploy_keys::params {

  $key_path     = "${base_folder}/${user}/${key_name}"

  notify { "Ensuring folder: ${base_folder}": }

  file { "${base_folder}" :
    ensure    => directory,
    owner     => $user,
    group     => 'root',
    mode      => '500',
  }

  notify { "Ensuring folder: ${user_folder}": }
  file { "${user_folder}" :
    ensure    => directory,
    owner     => $user,
    group     => 'root',
    mode      => '500',
    require   => File["${base_folder}"]
  }

  notify { "Ensuring deploy_keys file: ${key_path}": }
  file { "${key_path}" :
    ensure    => file,
    owner     => $user,
    group     => 'root',
    mode      => '400',    
    source    => $source,
    require   => File["${user_folder}"]
  }  
}

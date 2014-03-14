# == Class deploy_keys::params
#
# This class is meant to be called from deploy_keys
# It sets variables according to platform
#
class deploy_keys::params {
  $user        = "root"
  $base_folder = "/etc/puppet/.deploy_keys"
  $user_folder = "${base_folder}/${user}"
}

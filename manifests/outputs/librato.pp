# == Class: telegraf::outputs::librato
#
# Manage the "librato" output:
#
class telegraf::outputs::librato (
  $ensure         = present,
  $api_user       = 'telegraf@influxdb.com',
  $api_token      = 'my-secret-token',
  $name_from_tags = false,
  $source_tag     = undef,
  $timeout        = undef,
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/outputs-librato.conf":
      ensure  => file,
      content => template('telegraf/outputs/librato.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/outputs-librato.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

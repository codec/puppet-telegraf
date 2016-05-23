# == Class: telegraf::inputs::diskio
#
# Manage the "diskio" input:
#
class telegraf::inputs::diskio (
  $drop               = undef,
  $ensure             = present,
  $interval           = undef,
  $name_override      = undef,
  $name_prefix        = undef,
  $name_suffix        = undef,
  $pass               = undef,
  $tagdrop            = undef,
  $tagpass            = undef,
  $tags               = undef,
  $devices            = undef,
  $skip_serial_number = true,
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-diskio.conf":
      ensure  => file,
      content => template('telegraf/inputs/diskio.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-diskio.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

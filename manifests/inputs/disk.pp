# == Class: telegraf::inputs::disk
#
# Manage the "disk" input:
#
class telegraf::inputs::disk (
  $drop          = undef,
  $ensure        = present,
  $interval      = undef,
  $name_override = undef,
  $name_prefix   = undef,
  $name_suffix   = undef,
  $pass          = undef,
  $tagdrop       = undef,
  $tagpass       = undef,
  $tags          = undef,
  $mount_points  = undef,
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-disk.conf":
      ensure  => file,
      content => template('telegraf/inputs/disk.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-disk.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

# == Class: telegraf::inputs::system
#
# Manage the "system" input:
#
class telegraf::inputs::system(
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
) {

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-system.conf":
      ensure  => file,
      content => template('telegraf/inputs/system.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'],
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-system.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

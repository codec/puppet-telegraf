# == Class: telegraf::inputs::mem
#
# Manage the "mem" input:
#
class telegraf::inputs::mem(
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
    file { "${::telegraf::config_directory}/inputs-mem.conf":
      ensure  => file,
      content => template('telegraf/inputs/mem.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-mem.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

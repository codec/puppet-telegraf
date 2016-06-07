# == Class: telegraf::inputs::memcached
#
# Manage the "memcached" input:
#
class telegraf::inputs::memcached (
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
  $servers       = ['localhost:11211'],
  $unix_sockets  = [],
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-memcached.conf":
      ensure  => file,
      content => template('telegraf/inputs/memcached.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-memcached.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

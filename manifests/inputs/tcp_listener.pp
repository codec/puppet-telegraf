# == Class: telegraf::inputs::tcp_listener
#
# Manage the "tcp_listener" input:
#
class telegraf::inputs::tcp_listener (
  $drop                     = undef,
  $ensure                   = present,
  $interval                 = undef,
  $name_override            = undef,
  $name_prefix              = undef,
  $name_suffix              = undef,
  $pass                     = undef,
  $tagdrop                  = undef,
  $tagpass                  = undef,
  $tags                     = undef,
  $allowed_pending_messages = 10000,
  $data_format              = "influx",
  $max_tcp_connections      = 250,
  $service_address          = ":8094",
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-tcp_listener.conf":
      ensure  => file,
      content => template('telegraf/inputs/tcp_listener.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-tcp_listener.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

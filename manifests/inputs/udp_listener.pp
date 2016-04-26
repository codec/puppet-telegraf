# == Class: telegraf::inputs::udp_listener
#
# Manage the "udp_listener" input:
#
class telegraf::inputs::udp_listener (
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
  $udp_packet_size          = 1500,
  $service_address          = ":8092",
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-udp_listener.conf":
      ensure  => file,
      content => template('telegraf/inputs/udp_listener.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-udp_listener.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

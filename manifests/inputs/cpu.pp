# == Class: telegraf::inputs::cpu
#
# Manage the "cpu" input:
#
class telegraf::inputs::cpu (
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
  $percpu        = true,
  $totalcpu      = true,
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-cpu.conf":
      ensure  => file,
      content => template('telegraf/inputs/cpu.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-cpu.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

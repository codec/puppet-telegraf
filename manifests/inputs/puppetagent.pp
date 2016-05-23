# == Class: telegraf::inputs::puppetagent
#
# Manage the "puppetagent" input:
#
class telegraf::inputs::puppetagent (
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
  $location      = '/var/lib/puppet/state/last_run_summary.yaml',
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-puppetagent.conf":
      ensure  => file,
      content => template('telegraf/inputs/puppetagent.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-puppetagent.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

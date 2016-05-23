# == Class: telegraf::inputs::nsq
#
# Manage the "nsq" input:
#
class telegraf::inputs::nsq (
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
  $endpoints     = ['http://localhost:4151']
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-nsq.conf":
      ensure  => file,
      content => template('telegraf/inputs/nsq.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-nsq.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

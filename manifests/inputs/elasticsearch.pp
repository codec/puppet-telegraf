# == Class: telegraf::inputs::elasticsearch
#
# Manage the "elasticsearch" input:
#
class telegraf::inputs::elasticsearch (
  $drop           = undef,
  $ensure         = present,
  $interval       = undef,
  $name_override  = undef,
  $name_prefix    = undef,
  $name_suffix    = undef,
  $pass           = undef,
  $tagdrop        = undef,
  $tagpass        = undef,
  $tags           = undef,
  $cluster_health = true,
  $local          = true,
  $servers        = ['http://localhost:9200'],
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-elasticsearch.conf":
      ensure  => file,
      content => template('telegraf/inputs/elasticsearch.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-elasticsearch.conf":
      ensure => absent,
      notify => Service['telegraf'],
    }
  }

}

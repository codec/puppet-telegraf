# == Class: telegraf::inputs::statsd
#
# Manage the "statsd" input:
#
class telegraf::inputs::statsd (
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
  $delete_counters          = false,
  $delete_gauges            = false,
  $delete_sets              = false,
  $delete_timings           = true,
  $percentile_limit         = 1000,
  $percentiles              = [90],
  $service_address          = 'localhost:8125',
  $templates                = undef,
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/inputs-statsd.conf":
      ensure  => file,
      content => template('telegraf/inputs/statsd.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/inputs-statsd.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

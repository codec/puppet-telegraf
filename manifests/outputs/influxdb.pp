# == Class: telegraf::outputs::influxdb
#
# Manage the "influxdb" output:
#
class telegraf::outputs::influxdb (
  $ensure      = present,
  $urls        = ["http://localhost:8086"],
  $database    = "telegraf",
  $precision   = "s",
  $timeout     = "0",
  $username    = "telegraf",
  $password    = "metricsmetricsmetricsmetrics",
  $user_agent  = "telegraf",
  $udp_payload = 512,
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/outputs-influxdb.conf":
      ensure  => file,
      content => template('telegraf/outputs/influxdb.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/outputs-influxdb.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

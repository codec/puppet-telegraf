# == Class: telegraf::outputs::prometheus_client
#
# Manage the "prometheus_client" output:
#
class telegraf::outputs::prometheus_client (
  $ensure = present,
  $listen = ':9126',
){

  if $ensure == 'present' {
    file { "${::telegraf::config_directory}/outputs-prometheus_client.conf":
      ensure  => file,
      content => template('telegraf/outputs/prometheus_client.conf.erb'),
      mode    => '0444',
      owner   => 'root',
      group   => 'telegraf',
      notify  => Service['telegraf'];
    }
  } else {
    file { "${::telegraf::config_directory}/outputs-prometheus_client.conf":
      ensure  => absent,
      notify  => Service['telegraf'],
    }
  }

}

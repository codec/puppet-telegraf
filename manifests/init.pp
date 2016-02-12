# == Class: telegraf
#
# Manage InfluxDBs Telegraf monitoring agent:
#
class telegraf (
  $ensure                    = 'installed',
  $version                   = '0.10.2-1',
  $install_from_repository   = false,
  $config_file               = '/etc/telegraf/telegraf.conf',
  $config_directory          = '/etc/telegraf/telegraf.d',
  $tags                      = undef,
  $agent_debug               = false,
  $agent_flush_interval      = '10s',
  $agent_flush_jitter        = '0s',
  $agent_hostname            = $::hostname,
  $agent_interval            = '10s',
  $agent_round_interval      = true,
) {

  class { '::telegraf::package': } ~>
  class { '::telegraf::config': }  ~>
  class { '::telegraf::service': } ~>
  Class['telegraf']

}

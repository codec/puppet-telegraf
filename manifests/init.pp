# == Class: telegraf
#
# Manage InfluxDBs Telegraf monitoring agent:
#
class telegraf (
  $ensure                       = 'installed',
  $version                      = '0.12.1-1',
  $install_from_repository      = false,
  $config_file                  = '/etc/telegraf/telegraf.conf',
  $config_directory             = '/etc/telegraf/telegraf.d',
  $tags                         = undef,
  $agent_collection_jitter      = '0s',
  $agent_debug                  = false,
  $agent_flush_buffer_when_full = true,
  $agent_flush_interval         = '10s',
  $agent_flush_jitter           = '0s',
  $agent_hostname               = $::hostname,
  $agent_interval               = '10s',
  $agent_metric_buffer_limit    = 1000,
  $agent_round_interval         = true,

) {

  class { '::telegraf::package': } ~>
  class { '::telegraf::config': }  ~>
  class { '::telegraf::service': } ~>
  Class['telegraf']

}
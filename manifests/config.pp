# == Class: telegraf::config
#
class telegraf::config(
  $tags                         = $::telegraf::tags,
  $agent_collection_jitter      = $::telegraf::agent_collection_jitter,
  $agent_debug                  = $::telegraf::agent_debug,
  $agent_flush_buffer_when_full = $::telegraf::agent_flush_buffer_when_full,
  $agent_flush_interval         = $::telegraf::agent_flush_interval,
  $agent_flush_jitter           = $::telegraf::agent_flush_jitter,
  $agent_hostname               = $::telegraf::agent_hostname,
  $agent_interval               = $::telegraf::agent_interval,
  $agent_metric_buffer_limit    = $::telegraf::agent_metric_buffer_limit,
  $agent_round_interval         = $::telegraf::agent_round_interval,
) {

  # The main Telegraf config file:
  file { $::telegraf::config_file:
    ensure  => file,
    content => template('telegraf/telegraf.conf.erb'),
    mode    => '0444',
    owner   => 'root',
    group   => 'telegraf',
  }

  # The directory for config fragments (plugins etc):
  file { $::telegraf::config_directory:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'telegraf',
  }

}

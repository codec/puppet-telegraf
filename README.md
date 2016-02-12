# Puppet module for InfluxData's Telegraf

Telegraf (<https://github.com/influxdata/telegraf>) is a universal monitoring agent from InfluxData, which can forward metrics to many different systems and collect stats from many different things on your system using plugins. This puppet module supports the plugins which I personally use.

```manifests/package.pp``` is derived from <https://github.com/rplessl/puppet-telegraf>

## Sample profile using this module:
```
# == Class: profile::telegraf
#
# telegraf and plugins:
#
class profile::telegraf(
  $agent_flush_interval       = hiera('telegraf::agent_flush_interval', '60s'),
  $agent_hostname             = hiera('telegraf::agent_hostname', $::hostname),
  $agent_interval             = hiera('telegraf::agent_interval', '60s'),
  $ensure                     = hiera('telegraf::ensure', 'latest'),
  $install_from_repository    = hiera('telegraf::install_from_repository', true),
  $outputs_influxdb_urls      = hiera('telegraf::outputs_influxdb_urls', ['http://localhost:8086']),
  $outputs_influxdb_database  = hiera('telegraf::outputs_influxdb_database', 'telegraf'),
  $outputs_influxdb_username  = hiera('telegraf::outputs_influxdb_username', 'telegraf'),
  $outputs_influxdb_password  = hiera('telegraf::outputs_influxdb_password', 'metricsmetricsmetricsmetrics'),
  $enable_statsd_interface    = hiera('profile::telegraf::enable_statsd_interface', true),
  $statsd_service_address     = hiera('profile::telegraf::statsd_service_address', 'localhost:8125'),
  $tag_az                     = hiera('profile::telegraf::tag_az', $::ec2_placement_availability_zone),
  $tag_environment            = hiera('profile::telegraf::tag_environment', $::stage),
  $tag_region                 = hiera('profile::telegraf::tag_region', $::ec2_region),
  $tag_role                   = hiera('profile::telegraf::tag_role', $::role),
) {

  # Install the base telegraf service:
  class { '::telegraf':
    ensure                    => $ensure,
    install_from_repository   => $install_from_repository,
    tags                      => {
      az                      => $tag_az,
      environment             => $tag_environment,
      hostname                => $tag_hostname,
      region                  => $tag_region,
      role                    => $tag_role,
    },
    agent_flush_interval      => $agent_flush_interval,
    agent_hostname            => $agent_hostname,
    agent_interval            => $agent_interval,
  }

  # The InfluxDB output plugin:
  class { '::telegraf::outputs::influxdb':
    urls                      => $outputs_influxdb_urls,
    database                  => $outputs_influxdb_database,
    username                  => $outputs_influxdb_username,
    password                  => $outputs_influxdb_password,
  }

  # Monitor CPU utilisation:
  class { '::telegraf::inputs::cpu':
    drop                      => ['time_*'],
  }

  # Monitor filesystems:
  class { '::telegraf::inputs::disk': }

  # Monitor storage devices:
  class { '::telegraf::inputs::diskio': }

  # Monitor memory utilisation:
  class { '::telegraf::inputs::mem': }

  # Monitor network interfaces:
  class { '::telegraf::inputs::net':
    pass                      => ['bytes_*', 'drop_*', 'err_*'],
  }

  # Run a local StatsD interface:
  class { '::telegraf::inputs::statsd':
    interval                  => '120s',
    delete_counters           => true,
    delete_gauges             => true,
    delete_sets               => true,
    delete_timings            => true,
    percentiles               => [95],
    service_address           => $statsd_service_address,
  }

  # Monitor swap utilisation:
  class { '::telegraf::inputs::swap':
    ensure                    => 'absent',
  }

  # Monitor system utilisation (load averages etc):
  class { '::telegraf::inputs::system': }

}
```

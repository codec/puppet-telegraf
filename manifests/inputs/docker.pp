# == Class: telegraf::inputs::docker
#
# Manage the "docker" input:
#
class telegraf::inputs::docker (
  $drop               = undef,
  $ensure             = present,
  $interval           = undef,
  $name_override      = undef,
  $name_prefix        = undef,
  $name_suffix        = undef,
  $pass               = undef,
  $tagdrop            = undef,
  $tagpass            = undef,
  $tags               = undef,
  $endpoint           = 'unix:///var/run/docker.sock',
  $container_names    = []
) {
  file { "${::telegraf::config_directory}/inputs-docker.conf":
    ensure  => $ensure,
    content => template('telegraf/inputs/docker.conf.erb'),
    mode    => '0444',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }
}

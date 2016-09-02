# == Class: telegraf::inputs::apache
#
# Manage the "apache" input:
#
class telegraf::inputs::apache (
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
  $urls               = ['http://localhost/server-status?auto']
) {
  file { "${::telegraf::config_directory}/inputs-apache.conf":
    ensure  => $ensure,
    content => template('telegraf/inputs/apache.conf.erb'),
    mode    => '0444',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }
}

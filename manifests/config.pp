# == Class: telegraf::config
#
class telegraf::config {

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

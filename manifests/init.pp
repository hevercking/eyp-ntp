# == Class: ntp
#
# === ntp documentation
#
class ntp inherits ntp::params{

  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  Class['::ntp']

}

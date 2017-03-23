# == Class: ntp
#
# === ntp documentation
#
class ntp (
            $manage_package        = true,
            $package_ensure        = 'installed',
            $driftfile             = $ntp::params::driftfile_default,
            $tinker                = $tinker_default,
            $tinker_panic          = $tinker_panic_default,
            $servers               = $servers_default,
            $iburst                = true,
            $manage_service        = true,
            $manage_docker_service = true,
            $service_ensure        = 'running',
            $service_enable        = true,
            $restrict              = [ '127.0.0.1', '::1' ],
            $restrict_ipv4         = $ntp::params::restrict_ipv4_default,
            $restrict_ipv6         = $ntp::params::restrict_ipv6_default,
          ) inherits ntp::params {

  validate_array($servers)

  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  Class['::ntp']

}

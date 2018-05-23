# == Class: ntp
#
# === ntp documentation
#
class ntp (
            $manage_package        = true,
            $package_ensure        = 'installed',
            $driftfile             = $ntp::params::driftfile_default,
            $tinker                = $ntp::params::tinker_default,
            $tinker_panic          = $ntp::params::tinker_panic_default,
            $servers               = $ntp::params::servers_default,
            $iburst                = true,
            $manage_service        = true,
            $manage_docker_service = true,
            $service_ensure        = 'running',
            $service_enable        = true,
            $restrict              = [ '127.0.0.1', '::1' ],
            $restrict_ipv4         = $ntp::params::restrict_ipv4_default,
            $restrict_ipv6         = $ntp::params::restrict_ipv6_default,
            $statsdir              = undef,
            $force_ntpd            = false,
          ) inherits ntp::params {

  if($force_ntpd or !$ntp::params::systemd_timesync_available)
  {
    class { '::ntp::install': } ->
    class { '::ntp::config': } ~>
    class { '::ntp::service': } ->
    Class['::ntp']
  }
  else
  {
    include ::systemd

    class { 'systemd::timesyncd':
      servers => $servers,
    }
  }

}

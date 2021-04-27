class ntp::params {

  $package_name='ntp'

  if str2bool($::is_virtual)
  {
    $tinker_default = true
    $tinker_panic_default  = 0
  }
  else
  {
    $tinker_default = false
    $tinker_panic_default  = undef
  }

  case $::osfamily
  {
    'redhat':
    {
      $systemd_timesync_available=false
      $service_name='ntpd'
      $driftfile_default='/var/lib/ntp/drift'

      $restrict_ipv4_default = [
                                'default',
                                'kod',
                                'notrap',
                                'nomodify',
                                'nopeer',
                                'noquery',
                              ]
      $restrict_ipv6_default = [
                                'default',
                                'kod',
                                'notrap',
                                'nomodify',
                                'nopeer',
                                'noquery',
                              ]

      case $::operatingsystem
      {
        'RedHat':
        {
          case $::operatingsystemrelease
          {
            /^[5-8].*$/:
            {
              $servers_default = [
                                  '0.rhel.pool.ntp.org',
                                  '1.rhel.pool.ntp.org',
                                  '2.rhel.pool.ntp.org',
                                  '3.rhel.pool.ntp.org',
                                  ]
            }
            default: { fail("Unsupported RHEL version! - ${::operatingsystemrelease}")  }
          }
        }
        default:
        {
          case $::operatingsystemrelease
          {
            /^[5-8].*$/:
            {
              $servers_default = [
                                  '0.centos.pool.ntp.org',
                                  '1.centos.pool.ntp.org',
                                  '2.centos.pool.ntp.org',
                                  ]
            }
            default: { fail("Unsupported CentOS version! - ${::operatingsystemrelease}")  }
          }
        }
      }
    }
    'Debian':
    {
      $service_name='ntp'
      $driftfile_default='/var/lib/ntp/ntp.drift'

      case $::operatingsystem
      {
        'Ubuntu':
        {
          $servers_default = [
                              '0.debian.pool.ntp.org',
                              '1.debian.pool.ntp.org',
                              '2.debian.pool.ntp.org',
                              '3.debian.pool.ntp.org',
                              ]

          case $::operatingsystemrelease
          {
            # -restrict -4 default kod notrap nomodify nopeer noquery limited
            # -restrict -6 default kod notrap nomodify nopeer noquery limited
            /^14.*$/:
            {
              $systemd_timesync_available=false
              $restrict_ipv4_default = [
                                        'default',
                                        'kod',
                                        'notrap',
                                        'nomodify',
                                        'nopeer',
                                        'noquery',
                                      ]
              $restrict_ipv6_default = [
                                        'default',
                                        'kod',
                                        'notrap',
                                        'nomodify',
                                        'nopeer',
                                        'noquery',
                                      ]
            }
            /^16.*$/:
            {
              $systemd_timesync_available=false
              $restrict_ipv4_default = [
                                        'default',
                                        'kod',
                                        'notrap',
                                        'nomodify',
                                        'nopeer',
                                        'noquery',
                                        'limited',
                                      ]
              $restrict_ipv6_default = [
                                        'default',
                                        'kod',
                                        'notrap',
                                        'nomodify',
                                        'nopeer',
                                        'noquery',
                                        'limited',
                                      ]
            }
            /^18.*$/:
            {
              $systemd_timesync_available=true
              $restrict_ipv4_default = [
                                        'default',
                                        'kod',
                                        'notrap',
                                        'nomodify',
                                        'nopeer',
                                        'noquery',
                                        'limited',
                                      ]
              $restrict_ipv6_default = [
                                        'default',
                                        'kod',
                                        'notrap',
                                        'nomodify',
                                        'nopeer',
                                        'noquery',
                                        'limited',
                                      ]
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $systemd_timesync_available=false

      case $::operatingsystem
      {
        'SLES':
        {
          $driftfile_default = '/var/lib/ntp/drift/ntp.drift'
          $restrict_ipv4_default = [
                                    'default',
                                    'kod',
                                    'notrap',
                                    'nomodify',
                                    'nopeer',
                                    'noquery',
                                  ]
          $restrict_ipv6_default = [
                                    'default',
                                    'kod',
                                    'notrap',
                                    'nomodify',
                                    'nopeer',
                                    'noquery',
                                  ]
          # pool.ntp.org
          $servers_default = [
                              '0.europe.pool.ntp.org',
                              '1.europe.pool.ntp.org',
                              '2.europe.pool.ntp.org',
                              '3.europe.pool.ntp.org'
                              ]
          case $::operatingsystemrelease
          {
            '11.3':
            {
              $service_name='ntp'
            }
            /^12.[34]/:
            {
              $service_name='ntpd'
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}

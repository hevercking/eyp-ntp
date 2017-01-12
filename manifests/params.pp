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
      $service_name='ntpd'
      $driftfile_default='/var/lib/ntp/drift'

      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
          $servers_default = [
                              '0.centos.pool.ntp.org',
                              '1.centos.pool.ntp.org',
                              '2.centos.pool.ntp.org',
                              ]
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $service_name='ntp'
      $driftfile_default='/etc/ntp.drift'

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $servers_default = [
                                  '0.debian.pool.ntp.org',
                                  '1.debian.pool.ntp.org',
                                  '2.debian.pool.ntp.org',
                                  '3.debian.pool.ntp.org',
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
      $service_name='ntp'

      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            '11.3':
            {
              # pool.ntp.org
              $servers_default = [
                                  '0.europe.pool.ntp.org',
                                  '1.europe.pool.ntp.org',
                                  '2.europe.pool.ntp.org',
                                  '3.europe.pool.ntp.org'
                                  ]
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

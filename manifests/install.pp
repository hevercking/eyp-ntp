class ntp::install inherits ntp {

  if($ntp::manage_package)
  {
    package { $ntp::params::package_name:
      ensure => $ntp::package_ensure,
    }
  }

}

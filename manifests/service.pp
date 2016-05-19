class ntp::service() inherits ntp {

  #
  validate_bool($ntp::manage_docker_service)
  validate_bool($ntp::manage_service)
  validate_bool($ntp::service_enable)

  validate_re($ntp::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${ensure}")

  if(getvar('::eyp_docker_iscontainer')==undef or
      getvar('::eyp_docker_iscontainer')==false or
      getvar('::eyp_docker_iscontainer') =~ /false/ or
      $manage_docker_service)
  {
    if($manage_service)
    {
      service { 'ntp':
        ensure     => $ntp::service_ensure,
        enable     => $ntp::service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}

class ntp::service() inherits ntp {

  #
  validate_bool($ntp::manage_docker_service)
  validate_bool($ntp::manage_service)
  validate_bool($ntp::service_enable)

  validate_re($ntp::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${ntp::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $ntp::manage_docker_service)
  {
    if($ntp::manage_service)
    {
      service { $ntp::params::service_name:
        ensure     => $ntp::service_ensure,
        enable     => $ntp::service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}

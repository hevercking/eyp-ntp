class ntp::service inherits ntp {

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

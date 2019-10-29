class ntp::config inherits ntp {

  file { '/etc/ntp.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/ntp.erb"),
  }

}

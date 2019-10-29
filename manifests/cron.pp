define ntp::cron(
                  $server     = $name,
                  $ensure     = 'present',
                  $hour       = '*',
                  $minute     = '*/30',
                  $month      = undef,
                  $monthday   = undef,
                  $weekday    = undef,
                ) {

  cron { "cron ntpdate ${server}":
    ensure   => $ensure,
    command  => "ntpdate ${server}",
    user     => 'root',
    hour     => $hour,
    minute   => $minute,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday,
    requrire => Class['::ntp'],
  }
}

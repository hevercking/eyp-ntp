
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $ntpservice = 'ntpd'

when 'Debian'
  $ntpservice = 'ntp'

else
  $ntpservice = '-_-'

end

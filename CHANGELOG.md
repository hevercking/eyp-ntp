# CHANGELOG

## 0.1.10

* added support for Ubuntu 18.04
* added timesync as the default NTP client for Ubuntu 18.04, can be enforced to use ntp setting **force_ntpd** to true

## 0.1.9

* bugfix: custom **statsdir**

## 0.1.8

* added custom default servers for **RHEL**

## 0.1.7

* bugfix servers
* bugfix acceptance testing

## 0.1.6

* typo restrict ipv6
* added default statistics only if **statsdir** is defined

## 0.1.5

* allow **ntp::servers** variable to be empty
* changed driftfile for Ubuntu

## 0.1.4

* added a variable to be able to restrict access
* Ubuntu 16.04 support
* added ipv4 and ipv6 restrict options as a variable

## 0.1.3

* changed driftfile for CentOS to **/var/lib/ntp/drift**

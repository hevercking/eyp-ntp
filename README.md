# ntp

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What ntp affects](#what-ntp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ntp](#beginning-with-ntp)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

Installs, configures, and manages the NTP service.

## Module Description

The ntp module handles installing, configuring, and running NTP.

## Setup

### What ntp affects

* NTP config file: /etc/ntp.conf
* ntp package
* ntp service

### Setup Requirements

This module requires pluginsync enabled

### Beginning with ntp

This module setups NTP to use a given set of servers (it also has some default servers).

If this module is used on a VM, by default, it will set tinker panic to 0

## Usage

basic usage:

```puppet
	class { 'ntp':
    servers = [
                '1.ie.pool.ntp.org',
            	   '0.europe.pool.ntp.org',
            	   '3.europe.pool.ntp.org'
                 ]
  }
```

## Reference

### classes

#### ntp

* **driftfile**: File to use to record the frequency offset of the local clock oscillator
* **tinker**: Enables or disables system variables used by the clock discipline algorithm.
* **tinker_panic**: Specifies the panic threshold in seconds. If set to zero, the panic sanity check is disabled and a clock offset of any value will be accepted.
* **servers**:: List of servers to use
* **iburst**: When  the  server is unreachable, send a burst of eight packets instead of the usual one (default: true)
* management options:
  * **manage_package**: Package management (default: true)
  * **package_ensure**: Package status: (default: installed)
  * **manage_service**: Service management (default: true)
  * **manage_docker_service**: Service management on docker containers (default: true)
  * **service_ensure**: Service status: (default: running)
  * **service_enable**: Service enabled on startup: (default: true)


## Limitations

Tested on:

* CentOS 5
* CentOS 6
* CentOS 7
* Ubunutu 14.04
* SLES 11 SP3

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

Nothing yet

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

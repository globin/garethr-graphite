class graphite::install {

  include python

  package {[
    'python-ldap',
    'python-cairo',
    'python-twisted',
    'python-django-tagging',
    'python-simplejson',
    'libapache2-mod-python',
    'python-memcache',
    'python-pysqlite2',
    'python-support',
  ]:
    ensure => latest;
  }

  exec { 'ensure-old-enough-django-for-graphite-web':
    path => ['/usr/bin', '/usr/local/bin'],
    command => 'pip install Django\<1.4',
    creates => '/usr/local/bin/django-admin.py',
    require => Package['python-pip'],
  }

  exec { 'install-carbon':
    command => 'pip install carbon',
    creates => '/opt/graphite/lib/carbon',
    require => Class['python'],
  }

  exec { 'install-graphite-web':
    command => 'pip install graphite-web',
    creates => '/opt/graphite/webapp/graphite',
    require => Class['python'],
  }

  package { 'whisper':
    ensure   => installed,
    provider => pip,
    require => Class['python'],
  }

  file { '/var/log/carbon':
    ensure => directory,
    owner  => www-data,
    group  => www-data,
  }

}

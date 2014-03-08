class graphite(
  $admin_password = $graphite::params::admin_password,
  $port = $graphite::params::port,
  $manage_python = $graphite::params::manage_python,
  $manage_webserver = graphite::params::webserver,
) inherits graphite::params {
  class{'graphite::install': } ->
  class{'graphite::config': } ~>
  class{'graphite::service': } ->
  Class['graphite']
}

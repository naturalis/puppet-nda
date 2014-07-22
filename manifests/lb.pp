#
#
#
class nda::lb (
  $nda_cluster_id,
  $port = '8080',
  $ip = undef,
  ){

  if ($ip) {
    $ip_real = $ip
  }else{
    $ip_real = $::ipaddress
  }

  class { 'haproxy': }

  haproxy::listen { $nda_cluster_id :
    ipaddress => $ip_real,
    ports     => $port,
  }

  Haproxy::Balancermember <<| listening_service == $nda_cluster_id |>> {
    require => Haproxy::Listen[$nda_cluster_id],
  }




}

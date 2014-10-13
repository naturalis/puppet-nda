# == Class: nda
#
# Full description of class nda here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { nda:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class nda (
  $nda_cluster_id,
  $admin_password = 'nda',
  $application_name  = 'nda',
  $port = '8080',
){

  # base::users { 'ayco.holleman':
  #   comment => 'ayco.holleman@naturalis.nl',
  #   ssh_key => { key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDXBzKjMOITaKnN3SXX/PIbwma518Z92oRkOOSW+D6lk7Ln1/mCoAHD7YfjYIoZV7PJyF9rQW3FVI5Hj9mi1OYTz3GQ6s+Iys2VM+rpq1N3KCnvVcRpABl9VOZcCyBAJ1JW2ka3gQoWgMfadVZidrMa0IEN1+3ITk7hgIodTx4l/b+TAcxtPYSo+Jr1AaF8fuf3VKP1Ko4EWuR3mwJQmkTymnHqggBfqJE/ulLQIeMUKZCREg5VSH+LUg1Gh6hRyKDnHce7hmPyE3Vm5k3zCvTaDHQXjnnV+kubgZXD4P/Gs3nakuu6BUU/17tt0QMupVuVdgAznbBkitADy+aCVAgD",
  #                comment => 'ayco.holleman@naturalis.nl',
  #                type => 'ssh-rsa'},
  # }

  package {'subversion' : }

  package {'openjdk-7-jdk' :} ->

  class { 'wildfly':
    bind_address            => $::ipaddress,
    use_web_download        => true,
    bind_address_management => $::ipaddress,
  } ->

  exec {'create wildfly admin user':
    command => "/bin/sh /opt/wildfly/bin/add-user.sh --silent ndaadmin ${admin_password} ",
    unless  => '/bin/cat /opt/wildfy/standalone/configuration/mgmt-users.properties | grep ndaadmin',
  }

  # exec {'create jboss admin user':
  #   command    => "/usr/bin/java -jar /opt/jboss/jboss-modules.jar -mp /opt/jboss/modules org.jboss.as.domain-add-user ndaadmin ${admin_password}",
  #   unless     => '/bin/cat /opt/jboss/standalone/configuration/mgmt-users.properties | grep ndaadmin',
  #   environment => 'JBOSS_HOME="/opt/jboss"',
  # }

  @@haproxy::balancermember {$::hostname :
    listening_service => $nda_cluster_id,
    ports             => $port,
    server_names      => $::hostname,
    ipaddresses       => $::ipaddress,
  }

  # jboss::instance { $application_name :
  #   user          => $application_name,   # Default is jboss
  #   group         => $application_name,   # Default is jboss
  #   createuser    => true,       # Default is true
  #   template      => "all",     # Default is default
  #   bindaddr      => $::ipaddress, # Default is 127.0.0.1
  #   port          => "80",      # Default is 8080
  #   init_timeout  => 10,        # Default is 0
  #   #run_conf      => "site/jboss/myapp/run.conf",  # Default is unset
  #   #conf_dir      => "site/jboss/myapp/conf",      # Default is unset
  #   #deploy_dir    => "site/jboss/myapp/deploy",    # Default is unset
  #   #deployers_dir => "site/jboss/myapp/deployers", # Default is unset
  #  }


}

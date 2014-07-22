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
  $loadbalancer_cluster,
  $application_name  = 'nda',
){

  package {'subversion' : }

  package {'openjdk-7-jdk' :} ->

  class { 'jboss':
    bindaddr => '0.0.0.0',
    version  => '7',
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

# == Class: nda::es
#
class nda::es (
  $nda_cluster_name,
	$es_version   = '1.2.2',
  $shards       = 3,
  $replicas     = 1,
  $es_memory_gb = 2,
  $es_data_dir  = '/data/elasticsearch',
  )

  {

  class{ 'elasticsearch':
    package_url               => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${es_version}.deb",
    config                    => {
        'node'                  => {
          'name'                => $::hostname
        },
        'index'                 => {
          'number_of_shards'    => $shards,
          'number_of_replicas'  => $replicas
        },
        'cluster'               => {
          'name'                => $cluster_name
        }
      },
    java_install              => true,
    init_defaults             => {
        'ES_HEAP_SIZE'          => "${$es_memory_gb}g",
        'DATA_DIR'              => $es_data_dir
    },
  }

}

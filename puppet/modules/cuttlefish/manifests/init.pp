class cuttlefish {

  include base::git
  include apt
  include aptconfig
  
  file { "${module_vcsrepo_root}/cuttlefish":
    ensure => directory,
    notify => Vcsrepo["${module_vcsrepo_root}/cuttlefish"],
  }

  vcsrepo { "${module_vcsrepo_root}/cuttlefish":
    ensure => present,
    provider => git,
    source => 'git://github.com/mlandauer/cuttlefish.git',
  }

  apt::force { "ruby2.1":
    release     => 'unstable',
    #version     => '2.1.5',
    cfg_files   => 'unchanged',
    cfg_missing => true,
    require => Apt::Source['debian_unstable'],
  }

  package { ["mysql-server", 
	     "postfix",
	     "imagemagick",
	     "libmagickwand-dev",
	     "libmysqld-dev"]:
    ensure => latest,
  }

}

class base {

  include base::git
  include base::modules

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
  }

  package { "git":
    ensure => latest,
  }

  package { "vim":
    ensure => latest,
  }

}

class base::modules {

  base::module { ["ruby", "apt"]:
    mode => "install",
  }

}

class base::git {

  base::module { "vcsrepo":
    mode => "install",
    require => Package["git"],
  }

  file { "${module_vcsrepo_root}":
    ensure => directory,
  }

}

define base::module($mode) {
  
  if $mode == "install" {
    $status = 0
  }
  else {
    $status = 1
  }

  exec { "puppet module ${mode} puppetlabs-${name}":
    path    => "/usr/bin:/usr/sbin:/bin",
    onlyif  => "test `puppet module list | grep puppetlabs-${name} | wc -l` -eq ${status}"
  }

}

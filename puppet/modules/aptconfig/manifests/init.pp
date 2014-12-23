class aptconfig {
  
  include apt

  apt::source { 'debian_unstable':
    comment           => 'This is the iWeb Debian unstable mirror',
    location          => 'http://debian.mirror.iweb.ca/debian/',
    release           => 'unstable',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring debian-archive-keyring',
    key               => '8B48AD6246925553',
    key_server        => 'subkeys.pgp.net',
    pin               => '-10',
    include_src       => true,
    include_deb       => true
  }

}

name             'chruby-build'
maintainer       'Vincent Durand'
maintainer_email 'vincent.durand@madwork.org'
license          'MIT'
description      'Chef cookbook to install chruby and build rubies from source with Google Perftools and LibYAML options.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'
supports         'ubuntu', '>= 12.04'
depends          'ark', '>= 0.6'

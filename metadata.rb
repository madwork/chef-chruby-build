name             'chruby-build'
maintainer       'Vincent Durand'
maintainer_email 'vincent.durand@madwork.org'
license          'MIT'
description      'Chef cookbook to install chruby and build rubies from source with Google Perftools and LibYAML options.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.0'
supports         'ubuntu', '>= 12.04'
depends          'ark', '>= 0.8'

source_url 'https://github.com/madwork/chef-chruby-build'        if respond_to? :source_url
issues_url 'https://github.com/madwork/chef-chruby-build/issues' if respond_to? :issues_url

recipe 'chruby-build::default', 'This recipe only installs chruby.'
recipe 'chruby-build::rubies',  'This recipe installs chruby and compile rubies from source.'

default['chruby_build']['version'] = "0.3.8"
default['chruby_build']['checksum'] = "d980872cf2cd047bc9dba78c4b72684c046e246c0fca5ea6509cae7b1ada63be"
default['chruby_build']['auto_switching'] = true

default['chruby_build']['rubies'] = []
default['chruby_build']['rubies_path'] = "/opt/rubies"
default['chruby_build']['rubies_libs'] = ["libssl-dev", "libreadline-dev", "zlib1g-dev"]

# https://code.google.com/p/gperftools/
default['chruby_build']['google_perftools']['enable'] = true
default['chruby_build']['google_perftools']['url'] = "https://gperftools.googlecode.com/files/gperftools-2.1.tar.gz"
default['chruby_build']['google_perftools']['version'] = "2.1"
default['chruby_build']['google_perftools']['checksum'] = "f3ade29924f89409d8279ab39e00af7420593baa4941c318db42e70ead7e494f"

# http://pyyaml.org/wiki/LibYAML
default['chruby_build']['libyaml']['enable'] = true
default['chruby_build']['libyaml']['url'] = "http://pyyaml.org/download/libyaml/yaml-0.1.6.tar.gz"
default['chruby_build']['libyaml']['version'] = "0.1.6"
default['chruby_build']['libyaml']['checksum'] = "7da6971b4bd08a986dd2a61353bc422362bd0edcc67d7ebaac68c95f74182749"

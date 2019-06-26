default['chruby_build']['version'] = "0.3.9"
default['chruby_build']['checksum'] = "7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd"
default['chruby_build']['auto_switching'] = true
default['chruby_build']['gemrc'] = true

default['chruby_build']['rubies'] = []
default['chruby_build']['rubies_path'] = "/opt/rubies"
default['chruby_build']['rubies_libs'] = ["libssl-dev", "libreadline-dev", "zlib1g-dev"]

default['chruby_build']['google_perftools']['enable'] = true
default['chruby_build']['google_perftools']['url'] = "https://github.com/gperftools/gperftools/archive/gperftools-2.7.tar.gz"
default['chruby_build']['google_perftools']['version'] = "2.7"
default['chruby_build']['google_perftools']['checksum'] = "3a88b4544315d550c87db5c96775496243fb91aa2cea88d2b845f65823f3d38a"

default['chruby_build']['libyaml']['enable'] = true
default['chruby_build']['libyaml']['url'] = "https://pyyaml.org/download/libyaml/yaml-0.2.1.tar.gz"
default['chruby_build']['libyaml']['version'] = "0.2.1"
default['chruby_build']['libyaml']['checksum'] = "78281145641a080fb32d6e7a87b9c0664d611dcb4d542e90baf731f51cbb59cd"

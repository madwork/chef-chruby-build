default['chruby_build']['version'] = "0.3.9"
default['chruby_build']['checksum'] = "7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd"
default['chruby_build']['auto_switching'] = true

default['chruby_build']['rubies'] = []
default['chruby_build']['rubies_path'] = "/opt/rubies"
default['chruby_build']['rubies_libs'] = ["libssl-dev", "libreadline-dev", "zlib1g-dev"]

default['chruby_build']['google_perftools']['enable'] = true
default['chruby_build']['google_perftools']['url'] = "https://github.com/gperftools/gperftools/releases/download/gperftools-2.3/gperftools-2.3.tar.gz"
default['chruby_build']['google_perftools']['version'] = "2.3"
default['chruby_build']['google_perftools']['checksum'] = "093452ad45d639093c144b4ec732a3417e8ee1f3744f2b0f8d45c996223385ce"

default['chruby_build']['libyaml']['enable'] = true
default['chruby_build']['libyaml']['url'] = "http://pyyaml.org/download/libyaml/yaml-0.1.7.tar.gz"
default['chruby_build']['libyaml']['version'] = "0.1.7"
default['chruby_build']['libyaml']['checksum'] = "8088e457264a98ba451a90b8661fcb4f9d6f478f7265d48322a196cec2480729"

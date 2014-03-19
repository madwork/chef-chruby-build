default['chruby_build']['version'] = "0.3.8"
default['chruby_build']['checksum'] = "d980872cf2cd047bc9dba78c4b72684c046e246c0fca5ea6509cae7b1ada63be"
default['chruby_build']['auto_switching'] = true
default['chruby_build']['rubies_path'] = "/opt/rubies"
default['chruby_build']['rubies_libs'] = ["libssl-dev", "libreadline-dev", "zlib1g-dev"]
default['chruby_build']['rubies'] = [
  {
    "version" => "2.1.1",
    "url" => "http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz",
    "checksum" => "c843df31ae88ed49f5393142b02b9a9f5a6557453805fd489a76fbafeae88941",
    "gems" => ["bundler"],
    "environment" => {
      "ARCHFLAGS" => "-arch x86_64", # uname -m
      "CFLAGS" => "-g -O2",
      "CPPFLAGS" => "-I/usr/include -I/usr/local/include"
    }
  }
]
default['chruby_build']['google_perftools'] = true # https://code.google.com/p/gperftools/
default['chruby_build']['libyaml'] = true # http://pyyaml.org/wiki/LibYAML

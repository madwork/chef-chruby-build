require 'spec_helper'

describe file('/usr/local/bin/chruby-exec') do
  it { should be_executable }
end

describe file('/usr/local/share/chruby/chruby.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end

describe file('/usr/local/share/chruby/auto.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end

describe file('/etc/profile.d/chruby.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end

describe file('/usr/local/lib/libtcmalloc_minimal.so') do
  it { should be_file }
end

describe package('libyaml-dev') do
  it { should_not be_installed }
end

describe package('libssl-dev') do
  it { should be_installed }
end

describe package('libreadline-dev') do
  it { should be_installed }
end

describe package('zlib1g-dev') do
  it { should be_installed }
end

describe file('/opt/rubies/ruby-2.1.1') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end

describe command('/usr/local/bin/chruby-exec ruby-2.1.1 -- "ruby -r rbconfig -e \'print RbConfig::CONFIG[\"configure_args\"]\'"') do
  it { should return_stdout "'--disable-install-doc' '--enable-shared' '--with-opt-dir=/usr/local' '--prefix=/opt/rubies/ruby-2.1.1' 'CFLAGS=-g -O2' 'LIBS=-ltcmalloc_minimal -lyaml' 'CPPFLAGS=-I/usr/include -I/usr/local/include'" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.1.1 -- "ruby -e \'print RUBY_VERSION\'"') do
  it { should return_stdout "2.1.1" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.1.1 -- "ruby -r yaml -e \'print Psych::LIBYAML_VERSION\'"') do
  it { should return_stdout "0.1.6" }
end

describe file('/opt/rubies/ruby-2.1.1/etc/gemrc') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode 644 }
end

describe package('bundler') do
  it { should be_installed.by('gem') }
end

describe command('which bundle') do
  it { should return_stdout "/opt/rubies/ruby-2.1.1/bin/bundle" }
end

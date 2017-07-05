require 'spec_helper'

describe file('/usr/local/bin/chruby-exec') do
  it { is_expected.to be_executable }
end

describe file('/usr/local/share/chruby/chruby.sh') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 644 }
end

describe file('/usr/local/share/chruby/auto.sh') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 644 }
end

describe file('/etc/profile.d/chruby.sh') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 644 }
end

describe package('libunwind7'), if: os[:release] == '12.04' do
  it { is_expected.to be_installed }
end

describe package('libunwind8'), if: os[:release] == '14.04' do
  it { is_expected.to be_installed }
end

describe package('libunwind8'), if: os[:release] == '16.04' do
  it { is_expected.to be_installed }
end

describe package('g++') do
  it { is_expected.to be_installed }
end

describe file('/usr/local/lib/libtcmalloc_minimal.so') do
  it { is_expected.to be_file }
end

describe file('/usr/local/lib/libyaml.so') do
  it { is_expected.to be_file }
end

describe package('libyaml-dev') do
  it { is_expected.to_not be_installed }
end

describe package('libssl-dev') do
  it { is_expected.to be_installed }
end

describe package('libreadline-dev') do
  it { is_expected.to be_installed }
end

describe package('zlib1g-dev') do
  it { is_expected.to be_installed }
end

describe file('/opt/rubies/ruby-2.3.4') do
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by 'root' }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -r rbconfig -e \'print RbConfig::CONFIG["configure_args"]\'') do
  its(:stdout) { is_expected.to eq " '--disable-install-doc' '--enable-shared' '--with-opt-dir=/usr/local' '--prefix=/opt/rubies/ruby-2.3.4' 'CFLAGS=-g -O2' 'LIBS=-ltcmalloc_minimal -lyaml' 'CPPFLAGS=-I/usr/include -I/usr/local/include'" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -e \'print RUBY_VERSION\'') do
  its(:stdout) { is_expected.to eq "2.3.4" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -r yaml -e \'print Psych::LIBYAML_VERSION\'') do
  its(:stdout) { is_expected.to eq "0.1.7" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -r readline -e \'print Readline::VERSION\''), if: os[:release] == '12.04' do
  its(:stdout) { is_expected.to eq "6.2" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -r readline -e \'print Readline::VERSION\''), if: os[:release] == '14.04' do
  its(:stdout) { is_expected.to eq "6.3" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -r readline -e \'print Readline::VERSION\''), if: os[:release] == '16.04' do
  its(:stdout) { is_expected.to eq "6.3" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.3.4 -- ruby -r openssl -e \'print OpenSSL::VERSION\'') do
  its(:stdout) { is_expected.to eq "1.1.0" }
end

describe file('/opt/rubies/ruby-2.3.4/etc/gemrc') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 644 }
end

describe package('bundler') do
  it { is_expected.to be_installed.by('gem') }
end

describe command('which bundle') do
  its(:stdout) { is_expected.to eq "/opt/rubies/ruby-2.3.4/bin/bundle\n" }
end

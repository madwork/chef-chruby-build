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

describe package('libunwind7') do
  it { is_expected.to_not be_installed }
end

describe package('libyaml-dev') do
  it { is_expected.to be_installed }
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

describe file('/opt/rubies/ruby-2.4.1') do
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by 'root' }
end

describe command('/usr/local/bin/chruby-exec ruby-2.4.1 -- ruby -r rbconfig -e \'print RbConfig::CONFIG["configure_args"]\'') do
  its(:stdout) { is_expected.to eq " '--disable-install-doc' '--enable-shared' '--with-opt-dir=/usr/local' '--prefix=/opt/rubies/ruby-2.4.1'" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.4.1 -- ruby -e \'print RUBY_VERSION\'') do
  its(:stdout) { is_expected.to eq "2.4.1" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.4.1 -- ruby -r yaml -e \'print Psych::LIBYAML_VERSION\''), if: os[:release] == '12.04' do
  its(:stdout) { is_expected.to eq "0.1.4" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.4.1 -- ruby -r yaml -e \'print Psych::LIBYAML_VERSION\''), if: os[:release] == '14.04' do
  its(:stdout) { is_expected.to eq "0.1.4" }
end

describe command('/usr/local/bin/chruby-exec ruby-2.4.1 -- ruby -r yaml -e \'print Psych::LIBYAML_VERSION\''), if: os[:release] == '16.04' do
  its(:stdout) { is_expected.to eq "0.1.6" }
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

describe command('/usr/local/bin/chruby-exec ruby-2.4.1 -- ruby -r openssl -e \'print OpenSSL::VERSION\'') do
  its(:stdout) { is_expected.to eq "2.0.3" }
end

describe file('/opt/rubies/ruby-2.4.1/etc/gemrc') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 644 }
end

describe package('bundler') do
  it { is_expected.to be_installed.by('gem') }
end

describe package('pry') do
  it { is_expected.to be_installed.by('gem') }
end

describe command('which bundle') do
  its(:stdout) { is_expected.to eq "/opt/rubies/ruby-2.4.1/bin/bundle\n" }
end

describe command('which pry') do
  its(:stdout) { is_expected.to eq "/opt/rubies/ruby-2.4.1/bin/pry\n" }
end

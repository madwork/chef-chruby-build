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

describe file('/opt/rubies/ruby-2.4.5') do
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by 'root' }
end

describe "ruby-2.4.5" do
  before { command('chruby ruby-2.4.5') }

  describe command('ruby -r rbconfig -e \'print RbConfig::CONFIG["configure_args"]\'') do
    its(:stdout) { is_expected.to eq " '--disable-install-doc' '--enable-shared' '--with-opt-dir=/usr/local' '--prefix=/opt/rubies/ruby-2.4.5' 'LIBS=-ltcmalloc_minimal' 'CPPFLAGS=-I/usr/include -I/usr/local/include'" }
  end

  describe command('ruby -e \'print RUBY_VERSION\'') do
    its(:stdout) { is_expected.to eq "2.4.5" }
  end

  if os[:release] == '18.04'
    describe command('ruby -r yaml -e \'print Psych::LIBYAML_VERSION\'') do
      its(:stdout) { is_expected.to eq "0.1.7" }
    end

    describe command('ruby -r openssl -e \'print OpenSSL::OPENSSL_LIBRARY_VERSION\'') do
      its(:stdout) { is_expected.to eq "OpenSSL 1.1.0g  2 Nov 2017" }
    end

    describe command('ruby -r readline -e \'print Readline::VERSION\'') do
      its(:stdout) { is_expected.to eq "7.0" }
    end

    describe command('ruby -r zlib -e \'print Zlib::ZLIB_VERSION\'') do
      its(:stdout) { is_expected.to eq "1.2.11" }
    end
  end
end

describe file('/opt/rubies/ruby-2.4.5/etc/gemrc') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_mode 644 }
end

describe package('bundler') do
  it { is_expected.to be_installed.by('gem').with_version('1.17.1') }
end

describe package('pry') do
  it { is_expected.to be_installed.by('gem') }
end

describe command('which bundle') do
  its(:stdout) { is_expected.to eq "/opt/rubies/ruby-2.4.5/bin/bundle\n" }
end

describe command('which pry') do
  its(:stdout) { is_expected.to eq "/opt/rubies/ruby-2.4.5/bin/pry\n" }
end

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

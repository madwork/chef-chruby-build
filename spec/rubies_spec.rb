require_relative 'spec_helper'

describe "chruby-build::rubies" do
  let(:rubies) { JSON.parse File.read("spec/fixtures/ruby-2.3.4.json") }

  before do
    stub_data_bag('rubies').and_return(['ruby-2.3.4'])
    stub_data_bag_item('rubies', 'ruby-2.3.4').and_return(rubies)
  end

  it { is_expected.to include_recipe("chruby-build::default") }
  it { is_expected.to install_with_make_ark("ruby") }
  it { is_expected.to create_directory('/opt/rubies/ruby-2.3.4/etc') }
  it { is_expected.to create_template("/opt/rubies/ruby-2.3.4/etc/gemrc") }
  it { is_expected.to install_gem_package("bundler").with(version: "1.17.1") }
  it { is_expected.to install_gem_package("pry") }

  describe "rubies_libs attribute" do
    default_attributes['chruby_build']['rubies_libs'] = ["libssl-dev", "libreadline-dev", "zlib1g-dev"]

    it { is_expected.to upgrade_package("libssl-dev") }
    it { is_expected.to upgrade_package("libreadline-dev") }
    it { is_expected.to upgrade_package("zlib1g-dev") }
  end

  describe "gperftools enables" do
    default_attributes['chruby_build']['google_perftools']['enable'] = true

    it { is_expected.to install_package("g++") }
    it { is_expected.to install_package("libunwind8") }
    it { is_expected.to install_with_make_ark("google-perftools") }
  end

  describe "libyaml enables" do
    default_attributes['chruby_build']['libyaml']['enable'] = true

    it { is_expected.to install_with_make_ark("libyaml") }
  end

  describe "without default gemrc" do
    default_attributes['chruby_build']['gemrc'] = false

    it { is_expected.to_not create_directory('/opt/rubies/ruby-2.3.4/etc') }
    it { is_expected.to_not create_template("/opt/rubies/ruby-2.3.4/etc/gemrc") }
  end
end

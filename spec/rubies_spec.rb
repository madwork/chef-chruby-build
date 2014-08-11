require_relative 'spec_helper'

describe "chruby-build::rubies" do
  let(:chef_run) { ChefSpec::Runner.new }

  let(:rubies) { JSON.parse File.read("test/integration/rubies_data_bags/data_bags/rubies/ruby-2.1.1.json") }

  before do
    stub_data_bag('rubies').and_return(['ruby-2.1.1'])
    stub_data_bag_item('rubies', 'ruby-2.1.1').and_return(rubies)
    chef_run.converge(described_recipe)
  end

  it { expect(chef_run).to include_recipe("chruby-build::default") }
  it { expect(chef_run).to include_recipe("apt") }
  it { expect(chef_run).to install_with_make_ark("ruby") }
  it { expect(chef_run).to create_directory('/opt/rubies/ruby-2.1.1/etc') }
  it { expect(chef_run).to create_template("/opt/rubies/ruby-2.1.1/etc/gemrc") }
  it { expect(chef_run).to install_gem_package("bundler") }

  describe "rubies_libs attribute" do
    before do
      chef_run.node.set['chruby_build']['rubies_libs'] = ["libssl-dev", "libreadline-dev", "zlib1g-dev"]
      chef_run.converge(described_recipe)
    end

    it { expect(chef_run).to upgrade_package("libssl-dev") }
    it { expect(chef_run).to upgrade_package("libreadline-dev") }
    it { expect(chef_run).to upgrade_package("zlib1g-dev") }
  end

  describe "gperftools enables" do
    before do
      chef_run.node.set['chruby_build']['google_perftools']['enable'] = true
      chef_run.converge(described_recipe)
    end

    it { expect(chef_run).to install_package("g++") }
    it { expect(chef_run).to install_package("libunwind8") }
    it { expect(chef_run).to install_with_make_ark("google-perftools") }
  end

  describe "libyaml enables" do
    before do
      chef_run.node.set['chruby_build']['libyaml']['enable'] = true
      chef_run.converge(described_recipe)
    end

    it { expect(chef_run).to install_with_make_ark("libyaml") }
  end
end

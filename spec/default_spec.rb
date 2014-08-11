require_relative 'spec_helper'

describe "chruby-build::default" do
  let(:chef_run) { ChefSpec::Runner.new }

  before { chef_run.converge(described_recipe) }

  it { expect(chef_run).to include_recipe("ark") }
  it { expect(chef_run).to install_with_make_ark("chruby") }

  context "with auto_switching" do
    before do
      chef_run.node.set['chruby_build']['auto_switching'] = true
      chef_run.converge(described_recipe)
    end

    it { expect(chef_run).to create_template("/etc/profile.d/chruby.sh") }
  end

  context "without auto_switching" do
    before do
      chef_run.node.set['chruby_build']['auto_switching'] = false
      chef_run.converge(described_recipe)
    end

    it { expect(chef_run).to_not create_template("/etc/profile.d/chruby.sh") }
  end
end

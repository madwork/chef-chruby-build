require_relative 'spec_helper'

describe "chruby-build::default" do
  it { is_expected.to include_recipe("ark") }
  it { is_expected.to install_with_make_ark("chruby") }

  context "with auto_switching" do
    default_attributes['chruby_build']['auto_switching'] = true

    it { is_expected.to create_template("/etc/profile.d/chruby.sh") }
  end

  context "without auto_switching" do
    default_attributes['chruby_build']['auto_switching'] = false

    it { is_expected.to_not create_template("/etc/profile.d/chruby.sh") }
  end
end

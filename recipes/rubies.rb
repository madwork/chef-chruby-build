#
# Cookbook Name:: chruby-build
# Recipe:: rubies
#
# Copyright 2014, Vincent Durand
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe "chruby-build::default"

rubies = begin
  data_bag_rubies = data_bag('rubies')
  data_bag_rubies.map{ |rubie| data_bag_item('rubies', rubie).raw_data }
rescue Chef::Exceptions::InvalidDataBagPath, Chef::Exceptions::InvalidDataBagName
  Log.info "Missing data bags directory data_bags or data_bags/rubies, try with node attributes."
  node['chruby_build']['rubies']
end

if rubies.any?

  if node['chruby_build']['google_perftools']
    case node['platform_version']
    when "12.04"
      package "libunwind7"
    else
      package "libunwind8"
    end

    ark "google-perftools" do
      url "https://gperftools.googlecode.com/files/gperftools-2.1.tar.gz"
      version "2.1"
      checksum "f3ade29924f89409d8279ab39e00af7420593baa4941c318db42e70ead7e494f"
      autoconf_opts ["--enable-frame-pointers"]
      action :install_with_make
    end
  end

  node['chruby_build']['rubies_libs'].each do |lib|
    package lib do
      action :upgrade
    end
  end

  if node['chruby_build']['libyaml']
    ark "libyaml" do
      url "http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz"
      version "0.1.5"
      checksum "fa87ee8fb7b936ec04457bc044cd561155e1000a4d25029867752e543c2d3bef"
      autoconf_opts []
      action :install_with_make
    end
    execute "ldconfig"
  end

  rubies.each do |rubie|
    prefix_dir = File.join(node['chruby_build']['rubies_path'], rubie['id'])

    if node['chruby_build']['google_perftools']
      gperftools_ark_environment = if rubie.has_key?('environment')
        rubie['environment'].merge("LIBS" => [rubie['environment']['LIBS'], "-ltcmalloc_minimal"].compact.join(" "))
      else
        { "LIBS" => "-ltcmalloc_minimal" }
      end
    end

    rubie_ark = Hash[[:name, :version].zip(rubie['id'].split('-', 2))] # "ruby-2.0.0-p451" => {:name=>"ruby", :version=>"2.0.0-p451"}
    ark "ruby" do
      name rubie_ark[:name]
      version rubie_ark[:version]
      url rubie['url']
      checksum rubie['checksum'] if rubie.has_key?('checksum')
      environment gperftools_ark_environment || rubie.fetch('environment', {})
      autoconf_opts ["--disable-install-doc", "--enable-shared", "--libdir=/usr/lib", "--with-opt-dir=/usr/local/lib", "--prefix=#{prefix_dir}"]
      action :install_with_make
    end

    directory "gemrc" do
      path File.join(prefix_dir, "etc")
      owner "root"
      group "root"
    end

    template "gemrc" do
      path File.join(prefix_dir, "etc", "gemrc")
      source "gemrc"
      owner "root"
      group "root"
      mode "0644"
    end

    rubie['gems'].each do |gem_name|
      gem_package gem_name do
        gem_binary("chruby-exec #{rubie['id']} -- gem")
      end
    end
  end

end

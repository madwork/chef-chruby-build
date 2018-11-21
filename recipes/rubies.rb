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
require 'ostruct'

include_recipe "chruby-build::default"

begin
  rubies = data_bag('rubies').map{ |rubie| data_bag_item('rubies', rubie) }
rescue Chef::Exceptions::InvalidDataBagPath, Chef::Exceptions::InvalidDataBagName, Net::HTTPServerException => ex
  Log.warn ex.message
  Log.info "Missing data bags directory #{Chef::Config[:data_bag_path]}/rubies, try with node attributes."
end

rubies ||= node['chruby_build']['rubies']

if rubies.any?

  node['chruby_build']['rubies_libs'].each do |lib|
    package lib do
      action :upgrade
    end
  end

  execute "ldconfig" do
    command "ldconfig"
    action :nothing
  end

  gperftools = OpenStruct.new node['chruby_build']['google_perftools']
  libyaml    = OpenStruct.new node['chruby_build']['libyaml']

  if gperftools.enable
    package "g++"

    case node['platform_version']
    when "12.04"
      package "libunwind7"
    else
      package "libunwind8"
    end

    ark "google-perftools" do
      url gperftools.url
      version gperftools.version
      checksum gperftools.checksum
      autoconf_opts ["--enable-frame-pointers"]
      action :install_with_make
      notifies :run, "execute[ldconfig]", :immediately
    end
  end

  if libyaml.enable
    ark "libyaml" do
      url libyaml.url
      version libyaml.version
      checksum libyaml.checksum
      autoconf_opts []
      action :install_with_make
      notifies :run, "execute[ldconfig]", :immediately
    end
  end

  rubies.each do |rubie|
    prefix_dir = File.join(node['chruby_build']['rubies_path'], rubie['id'])

    ark_environment = rubie.fetch('environment', {})
    ark_environment.merge!("LIBS" => [ark_environment['LIBS'], "-ltcmalloc_minimal"].compact.join(" ")) if gperftools.enable
    ark_environment.merge!("LIBS" => [ark_environment['LIBS'], "-lyaml"].compact.join(" ")) if libyaml.enable

    ark_autoconf_opts = ["--disable-install-doc", "--enable-shared", "--with-opt-dir=/usr/local", "--prefix=#{prefix_dir}"]

    rubie_ark = Hash[[:name, :version].zip(rubie['id'].split('-', 2))] # "ruby-2.0.0-p451" => {:name=>"ruby", :version=>"2.0.0-p451"}
    ark "ruby" do
      name rubie_ark[:name]
      version rubie_ark[:version]
      url rubie['url']
      checksum rubie['checksum']
      environment ark_environment
      autoconf_opts ark_autoconf_opts
      action :install_with_make
    end

    directory "etc" do
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

    rubie['gems'].each do |gem|
      gem_name, gem_version = gem.split(' ')
      gem_package gem_name do
        gem_binary "chruby-exec #{rubie['id']} -- gem"
        version gem_version if gem_version
      end
    end
  end

end

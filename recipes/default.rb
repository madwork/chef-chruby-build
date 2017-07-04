#
# Cookbook Name:: chruby-build
# Recipe:: default
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

include_recipe "ark"

ark "chruby" do
  url "https://github.com/postmodern/chruby/archive/v#{node['chruby_build']['version']}.tar.gz"
  extension "tar.gz"
  version node['chruby_build']['version']
  checksum node['chruby_build']['checksum']
  action :install_with_make
end

if node['chruby_build']['auto_switching']
  template "/etc/profile.d/chruby.sh" do
    source "chruby.sh"
    owner "root"
    group "root"
    mode "0644"
  end
end

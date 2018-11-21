# Chruby Build Chef Cookbook

[![Build Status](https://img.shields.io/travis/madwork/chef-chruby-build.svg)](https://travis-ci.org/madwork/chef-chruby-build)
[![Cookbook Version](https://img.shields.io/cookbook/v/chruby-build.svg)](https://supermarket.chef.io/cookbooks/chruby-build)

Chef cookbook to install [chruby](https://github.com/postmodern/chruby) and build rubies from source with [Google Perftools](https://github.com/gperftools/gperftools) / [TCMalloc : Thread-Caching Malloc](http://goog-perftools.sourceforge.net/doc/tcmalloc.html) and [LibYAML](http://pyyaml.org/wiki/LibYAML) options.

## Requirements

#### supports

* `ubuntu >= 12.04`

#### depends

* `apt` - [Opscode Cookbook apt](https://supermarket.chef.io/cookbooks/apt)
* `ark` - [Opscode Cookbook ark](https://supermarket.chef.io/cookbooks/ark)

## Installation

### From the [Community Site](https://supermarket.chef.io/cookbooks/chruby-build)

Use the knife command:

```sh
$ knife cookbook site install chruby-build
```

### With [librarian-chef](https://github.com/applicationsonline/librarian-chef)

Edit `Cheffile`

    site "https://supermarket.chef.io/api/v1"

    cookbook 'chruby-build', '~> 0.4.0'

Resolves and installs all of the dependencies:

```sh
$ librarian-chef install
```

### With [berkshelf](http://berkshelf.com/)

Edit `Berksfile`

    source "https://supermarket.getchef.com"

    cookbook 'chruby-build', '~> 0.4.0'

Install the cookbooks you specified in the Berksfile and their dependencies:

```sh
$ berks install
```

## Attributes

See [attributes/default.rb](attributes/default.rb)

<table>
  <tr>
    <th>Description</th>
    <th>Type</th>
    <th>Default</th>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['version']</tt></td>
  </tr>
  <tr>
    <td>chruby version</td>
    <td>String</td>
    <td><tt>"0.3.9"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['checksum']</tt></td>
  </tr>
  <tr>
    <td>chruby checksum (SHA256)</td>
    <td>String</td>
    <td><tt>"7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['auto_switching']</tt></td>
  </tr>
  <tr>
    <td>chruby auto switching</td>
    <td>Boolean</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['rubies']</tt></td>
  </tr>
  <tr>
    <td>rubies to install</td>
    <td>Array</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['rubies_path']</tt></td>
  </tr>
  <tr>
    <td>path to install rubies</td>
    <td>String</td>
    <td><tt>"/opt/rubies"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['rubies_libs']</tt></td>
  </tr>
  <tr>
    <td>usefull libraries to install</td>
    <td>Array</td>
    <td><tt>["libssl-dev", "libreadline-dev", "zlib1g-dev"]</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['google_perftools']['enable']</tt></td>
  </tr>
  <tr>
    <td>compile rubies with google_perftools (tcmalloc)</td>
    <td>Boolean</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['google_perftools']['url']</tt></td>
  </tr>
  <tr>
    <td>google_perftools url</td>
    <td>String</td>
    <td><tt>"https://github.com/gperftools/gperftools/archive/gperftools-2.7.tar.gz"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['google_perftools']['version']</tt></td>
  </tr>
  <tr>
    <td>google_perftools version</td>
    <td>String</td>
    <td><tt>"2.7"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['google_perftools']['checksum']</tt></td>
  </tr>
  <tr>
    <td>google_perftools checksum</td>
    <td>String</td>
    <td><tt>"3a88b4544315d550c87db5c96775496243fb91aa2cea88d2b845f65823f3d38a"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['libyaml']['enable']</tt></td>
  </tr>
  <tr>
    <td>compile libyaml (latest release)</td>
    <td>Boolean</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['libyaml']['url']</tt></td>
  </tr>
  <tr>
    <td>libyaml url</td>
    <td>String</td>
    <td><tt>"https://pyyaml.org/download/libyaml/yaml-0.2.1.tar.gz"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['libyaml']['version']</tt></td>
  </tr>
  <tr>
    <td>libyaml version</td>
    <td>String</td>
    <td><tt>"0.2.1"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['libyaml']['checksum']</tt></td>
  </tr>
  <tr>
    <td>libyaml checksum</td>
    <td>String</td>
    <td><tt>"78281145641a080fb32d6e7a87b9c0664d611dcb4d542e90baf731f51cbb59cd"</tt></td>
  </tr>
</table>

## Usage

### Rubies attributes

* `id` - required id and **must be** split by a dash (eg. ruby-2.3.4)
* `url` - required ruby source
* `checksum` - optional sha256 package checksum
* `gems` - optional gems to install
* `environment` - optional compilation environment variables

#### With node attributes

```json
{
  "ark": {
    "prefix_root": "/usr/local/src"
  },
  "chruby_build": {
    "rubies": [
      {
        "id": "ruby-2.3.4",
        "url": "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.4.tar.gz",
        "checksum": "98e18f17c933318d0e32fed3aea67e304f174d03170a38fd920c4fbe49fec0c3",
        "gems": ["bundler"],
        "environment": {
          "ARCHFLAGS": "-arch x86_64",
          "CFLAGS": "-g -O2",
          "CPPFLAGS": "-I/usr/include -I/usr/local/include"
        }
      }
    ]
  }
}
```

#### With [data bags](http://docs.opscode.com/essentials_data_bags.html)

Data bag name **must be** `rubies`

```sh
$ knife data bag create rubies ruby-2.3.4
```

Edit data bag `ruby-2.3.4.json`

```json
{
  "id": "ruby-2.3.4",
  "url": "https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.4.tar.gz",
  "checksum": "98e18f17c933318d0e32fed3aea67e304f174d03170a38fd920c4fbe49fec0c3",
  "gems": ["bundler"],
  "environment": {
    "ARCHFLAGS": "-arch x86_64",
    "CFLAGS": "-g -O2",
    "CPPFLAGS": "-I/usr/include -I/usr/local/include"
  }
}
```

If you are using knife solo as provisioner, try [knife-solo_data_bag](http://thbishop.com/knife-solo_data_bag/).

Data bags have **higher** precedence.

### Recipes

#### chruby-build::default

This recipe only installs chruby.

Just include `chruby-build::default` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chruby-build::default]"
  ]
}
```

#### chruby-build::rubies

This recipe installs chruby and compile rubies from source.

Just include `chruby-build::rubies` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chruby-build::rubies]"
  ]
}
```

## Development

#### Dependencies

* [bundler](http://bundler.io/)
* [vagrant](https://www.vagrantup.com/)
* [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant)
* [berkshelf](http://berkshelf.com/)
* [serverspec](http://serverspec.org/)

#### Installation

Ensure the gem dependencies are installed:

```sh
$ bundle install
$ bundle exec berks install
```

Running unit tests:

```sh
$ bundle exec rspec
```

Running integration tests:

```sh
$ bundle exec kitchen test rubies-data-bags-ubuntu-1404
```

Different test suites are available:

```sh
$ bundle exec kitchen list
$ bundle exec kitchen setup default-ubuntu-1404
$ bundle exec kitchen verify default-ubuntu-1404
$ bundle exec kitchen destroy default-ubuntu-1404
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License

Written by [Vincent Durand](https://github.com/madwork).

Released under the terms of the MIT License. For further information, please see the file [LICENSE.txt](LICENSE.txt).

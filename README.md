# Chruby Build Chef Cookbook

[![Build Status](https://img.shields.io/travis/madwork/chef-chruby-build.svg)](https://travis-ci.org/madwork/chef-chruby-build)
[![Cookbook Version](https://img.shields.io/cookbook/v/chruby-build.svg)](https://supermarket.chef.io/cookbooks/chruby-build)

Chef cookbook to install [chruby](https://github.com/postmodern/chruby) and build rubies from source with [Google Perftools](https://github.com/gperftools/gperftools) / [TCMalloc : Thread-Caching Malloc](http://goog-perftools.sourceforge.net/doc/tcmalloc.html) and [LibYAML](http://pyyaml.org/wiki/LibYAML) options.

## Requirements

#### supports

* `ubuntu >= 12.04`

#### depends

* `ark >= 4.0.0` - [Opscode Cookbook ark](https://supermarket.chef.io/cookbooks/ark)

#### version

* `chef >= 13.4`

## Installation

### From the [Community Site](https://supermarket.chef.io/cookbooks/chruby-build)

Use the knife command:

```sh
$ knife supermarket install chruby-build
```

### With [berkshelf](http://berkshelf.com/)

Edit `Berksfile`

    source "https://supermarket.chef.io"

    cookbook 'chruby-build', '~> 1.0.1'

Install the cookbooks you specified in the Berksfile and their dependencies:

```sh
$ berks install
```

## Attributes

See [attributes/default.rb](attributes/default.rb)

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
        "id": "ruby-2.5.3",
        "url": "https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.3.tar.gz",
        "checksum": "9828d03852c37c20fa333a0264f2490f07338576734d910ee3fd538c9520846c",
        "gems": ["bundler 1.17.1"],
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
$ knife data bag create rubies ruby-2.5.3
```

Edit data bag `ruby-2.5.3.json`

```json
{
  "id": "ruby-2.5.3",
  "url": "https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.3.tar.gz",
  "checksum": "9828d03852c37c20fa333a0264f2490f07338576734d910ee3fd538c9520846c",
  "gems": ["bundler 1.17.1"],
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

* [bundler](https://bundler.io/)
* [vagrant](https://www.vagrantup.com/)
* [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant)
* [berkshelf](https://docs.chef.io/berkshelf.html)
* [serverspec](https://serverspec.org/)

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

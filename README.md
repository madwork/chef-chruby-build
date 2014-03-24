# Chruby Build Chef Cookbook

Chef cookbook to install [chruby](https://github.com/postmodern/chruby) and build rubies from source with [Google Perftools](https://code.google.com/p/gperftools/) and [LibYAML](http://pyyaml.org/wiki/LibYAML) options.

## Requirements

#### supports

* `ubuntu >= 12.04`

#### depends

* `apt` - [Opscode Cookbook apt](https://github.com/opscode-cookbooks/apt)
* `ark` - [Opscode Cookbook ark](https://github.com/opscode-cookbooks/ark)

## Attributes

#### chruby::default

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
    <td><tt>"0.3.8"</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['checksum']</tt></td>
  </tr>
  <tr>
    <td>chruby checksum (SHA256)</td>
    <td>String</td>
    <td><tt>"d980872cf2cd047bc9dba78c4b72684c046e246c0fca5ea6509cae7b1ada63be"</tt></td>
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
    <td colspan="3"><tt>['chruby_build']['google_perftools']</tt></td>
  </tr>
  <tr>
    <td>compile rubies with google_perftools (tcmalloc)</td>
    <td>Boolean</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td colspan="3"><tt>['chruby_build']['libyaml']</tt></td>
  </tr>
  <tr>
    <td>compile libyaml (latest release)</td>
    <td>Boolean</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### Rubies attributes

* `id` - required id and **must be** split by a dash (eg. ruby-2.1.1)
* `url` - required ruby source
* `checksum` - optional sha256 package checksum
* `gems` - optional gems to install
* `environment` - optional compilation environment variables

#### With node attributes

```json
{
  "chruby-build": {
    "rubies": [
      {
        "id": "ruby-2.1.1",
        "url": "http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz",
        "checksum": "c843df31ae88ed49f5393142b02b9a9f5a6557453805fd489a76fbafeae88941",
        "gems": ["bundler"],
        "environment": {
          "ARCHFLAGS": "-arch x86_64", # uname -m
          "CFLAGS": "-g -O2",
          "CPPFLAGS": "-I/usr/include -I/usr/local/include"
        }
      }
    ]
  }
}
```

#### With [data bags](http://docs.opscode.com/essentials_data_bags.html)

Data bag name **must be** rubies.

```sh
$ knife data bag create rubies ruby-2.1.1
```

Edit data bag `ruby-2.1.1.json`

```json
{
  "id": "ruby-2.1.1",
  "url": "http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz",
  "checksum": "c843df31ae88ed49f5393142b02b9a9f5a6557453805fd489a76fbafeae88941",
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

This recipe only install chruby.

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

This recipe install chruby and compile rubies from source if specified.

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

#### Installation

Ensure the gem dependencies are installed:

```sh
$ bundle install
$ bundle exec berks install
```

Running the tests:

```sh
$ bundle exec kitchen test
```

## Contributing

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License

Written by [Vincent Durand](https://github.com/madwork).

Released under the terms of the MIT License. For further information, please see the file [LICENSE.txt](LICENSE.txt).

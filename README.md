[![Build Status](https://travis-ci.com/rochefort/mb_string.svg?branch=master)](https://travis-ci.com/rochefort/mb_string)
[![Coverage Status](http://img.shields.io/coveralls/rochefort/mb_string.svg?style=flat)](https://coveralls.io/r/rochefort/mb_string)
[![Maintainability](https://api.codeclimate.com/v1/badges/07f73faf046781ff16fb/maintainability)](https://codeclimate.com/github/rochefort/mb_string/maintainability)
[![Gem Version](http://img.shields.io/gem/v/mb_string.svg?style=flat)](http://badge.fury.io/rb/mb_string)


# mb_string

`mb_string` is extended Ruby string class for dealing multi-byte strings, add `mb_ljust`, `mb_rjust`, `mb_center` and `mb_truncate` methods.  

## Requirements

Ruby versions is earlier than 2.0.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mb_string'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mb_string

## Usage
`mb_ljust`, `mb_rjust` and `mb_center`:

    require 'mb_string'
    "あいうえお".mb_ljust(20)
    => "あいうえお          "

    "あいうえお".mb_ljust(20, 'ん')
    => "あいうえおんんんんん"

    "あいうえお".mb_ljust(20, 'ほげ')
    => "あいうえおほげほげほ"

`mb_truncate`:

    require 'mb_string'
    "あいうえお".mb_truncate(6)
    => "あ..."

    "あいうえお".mb_truncate(8, omission: 'ほげ')
    => "あいほげ"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rochefort/mb_string.

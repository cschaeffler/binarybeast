# Binarybeast

This is a Ruby Gem to access the BinaryBeast.com API.

## Installation

Add this line to your application's Gemfile:

    gem 'binarybeast'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install binarybeast

## Usage

    @tourney = Binarybeast::Tourney.new

there are several options you can use when creating a tourney:
    :title => "Test"
    :description => "Lorem ipsum"
... and more...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

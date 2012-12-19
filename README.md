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

    :title => String
    :description => String
    :public => Integer
    :gamecode => String
    :typeid => Integer
    :elimination => Integer
    :teammode => Integer
    :groupcount => Integer
    :teamsfromgroup => Integer
    :location => String
    :maxteams => Integer
    :replayuploads => Integer
    :replaydownloads => Integer
    :autostart => Integer
    :returndata => Integer

however, only :title => String is required or :tourneyid => String if you want to load an existing tournament.

## Create a new Tournament on BinaryBeast

    @tourney = Binarybeast::Tourney.new(:title => "Test Tournament", :description => "This comes from a ruby gem accessing your api.")
    @tourney.create
    
## Fetching a existing Tournament from BinaryBeast

    @tourney = Binarybeast::Tourney.new(:tourneyid => "xSC21212194")
    @tourney.load

## Current implemented Functions

This is a pre release of the gem soon to be. Current functions include

    .new
    .create
    .update
    .load
    .delete
    .setBuild
    .setConfirmation
    .start

more to come soon....

## Some stuff you should know

The BinaryBeast API sends back JSON from every request. However, if you use this gem we catch the JSON Data and proccess it. If you want to have a direct access to the API you can go with something like this:

    @tourney = Binarybeast::Tourney.new(:title => "Test")
    response = @tourney.create(:force => true)
    
the :force => true tells the function to give you the callback from the binarybeast directly. The response is now a parsed hash, so this will work

    response["Result"]
    => 200

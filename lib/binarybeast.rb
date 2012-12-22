require "HTTParty"

# Binarybeast
# Module
# ---------------------
# has 1 variable called api_key, this is your api_key. the default is the api_key from gamkoi.com
# Example
# Binarybeast.api_key = "12345"
# => "12345"
# ---------------------
# does contain all the classes that interact with binarybeast api.

module Binarybeast
  include HTTParty
  # Base URI for the BinaryBeast API
  base_uri 'https://binarybeast.com/api'
  # Set HTTParty standard format to JSON, its standard what binarybeast api returns.
  format :json
  # Default api_key, this one is taken from my personal account.
  @@api_key = "3c8955130c6e1406420d6202649651fe.50c9faa593f9c6.00530099"
  
  autoload :Tourney, 'binarybeast/tourney'
  autoload :Team, 'binarybeast/team'

  # Getter for api_key Variable
  def self.api_key
    @@api_key
  end
  
  # Setter for api_key Variable
  def self.api_key=(api_key)
    @@api_key=api_key
  end  

end

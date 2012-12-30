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

module BinaryBeast
  include HTTParty
  # Base URI for the BinaryBeast API
  base_uri 'https://api.binarybeast.com/'
  # Set HTTParty standard format to JSON, its standard what binarybeast api returns.
  format :json
  # Default api_key, this one is taken from my personal account.
  # @todo the api key should not be initialized with a personal account for the public release, 
  # in the future, use the test account api if anything: e17d31bfcbedd1c39bcb018c5f0d0fbf.4dcb36f5cc0d74.24632846
  @@api_key = '3c8955130c6e1406420d6202649651fe.50c9faa593f9c6.00530099'

  # Autoload the service classes
  require                   'binarybeast/constants'
  autoload :Service,        'binarybeast/service'
  autoload :Tournament,     'binarybeast/tournament'
  autoload :Team,           'binarybeast/team'
  autoload :Game,           'binarybeast/game'
  

  # Getter for api_key Variable
  def self.api_key
    @@api_key
  end

  # Setter for api_key Variable
  def self.api_key=(api_key)
    @@api_key=api_key
  end

  # Call
  # Method
  # ------------
  # Raw Call Method for those who want to make raw calls on the API of Binarybeast. api_key will be taken from the module variable
  # Example:
  # tourney = Binarybeast.call('Tourney.TourneyCreate.Create', :title => "Test")
  # ------------

  def self.call(service, options={})
    options.merge!({
      :api_key              => @@api_key,
      :api_use_underscores  => true,
      :api_service          => service,
      :api_agent            => "BinaryBeast API Ruby: Version #{BinaryBeast::VERSION}"
    })

    response = self.get('', :query => options)

    yield response if block_given?
    return response

  end

end
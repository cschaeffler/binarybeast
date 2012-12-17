require "HTTParty"
Dir[File.dirname(__FILE__) + '/binarybeast/*.rb'].each do |file|
  require file
end

# Binarybeast
# Module
# ---------------------
# has 1 variable called apikey, this is your apikey. the default is the apikey from gamkoi.com
# Example
# Binarybeast.apikey = "12345"
# => "12345"
# ---------------------
# does contain all the classes that interact with binarybeast api.

module Binarybeast
  include HTTParty
  # Base URI for the BinaryBeast API
  base_uri 'https://binarybeast.com/api'
  # Set HTTParty standard format to JSON, its standard what binarybeast api returns.
  format :json
  # Default APIKey, this one is taken from my personal account.
  @@apikey = "3c8955130c6e1406420d6202649651fe.50c9faa593f9c6.00530099"
  
  # Getter for APIKey Variable
  def self.apikey
    @@apikey
  end
  
  # Setter for APIKey Variable
  def self.apikey=(apikey)
    @@apikey=apikey
  end  
  
  # Tourney
  # Class
  # ---------------
  # This is the Tourney class. It will be used to most. It gives you a brand new Tourney object to call methods on.
  # Example:
  # tourney = Binarybeast::Tourney.new("Gamkoi Test")
  # ---------------
  # gives you a tourney object
  
  class Tourney
    include HTTParty
    base_uri 'https://binarybeast.com/api'
    format :json
    attr_accessor :apikey, :tourneyid, :title, :publish, :gamecode, :typeid, :elimination, :teammode, :groupcount, :teamsfromgroup, :datestart, :location, :maxteams, :replayuploads, :replaydownloads, :description, :returndata
    
    # Constructor
    # Method
    # ----------------
    # all tourney attributes can be given here. The Name parameter is needed, all else is optional.
    # Example:
    # Tourney.new(:title => "Gamkoi DevCup")
    # ----------------
    def initialize(options)
      options[:title] ? self.title = options[:title] : self.title = "Test"
      options[:public] ? self.publish = options[:public] : self.publish = 0
      options[:gamecode] ? self.gamecode = options[:gamecode] : self.gamecode = ""
      options[:typeid] ? self.typeid = options[:typeid] : self.typeid = 0
      options[:elimination] ? self.elimination = options[:elimination] : self.elimination = 1
      options[:teammode] ? self.teammode = options[:teammode] : self.teammode = 1
      options[:groupcount] ? self.groupcount = options[:groupcount] : self.groupcount = 1
      options[:teamsfromgroup] ? self.teamsfromgroup = options[:teamsfromgroup] : self.teamsfromgroup = 2
      options[:datestart] ? self.datestart = options[:datestart] : self.datestart = nil
      options[:location] ? self.location = options[:location] : self.location = ""
      options[:maxteams] ? self.maxteams = options[:maxteams] : self.maxteams = 16
      options[:replayuploads] ? self.replayuploads = options[:replayuploads] : self.replayuploads = 1
      options[:replaydownloads] ? self.replaydownloads = options[:replaydownloads] : self.replaydownloads = 1
      options[:description] ? self.description = options[:description] : self.description = ""
      options[:returndata] ? self.returndata = options[:returndata] : self.returndata = 0
      options[:apikey] ? self.apikey = options[:apikey] : self.apikey = Binarybeast.apikey
    end

    def update
    end

    def broadcast(force=false)
      response = self.class.get("", :query => {:APIKey => self.apikey, :APIService => "Tourney.TourneyCreate.Create",
                                    :Title => self.title, :Public => self.publish, :GameCode => self.gamecode,
                                    :TypeID => self.typeid, :Elimination => self.elimination,
                                    :TeamMode => self.teammode, :GroupCount => self.groupcount,
                                    :TeamsFromGroup => self.teamsfromgroup, :DateStart => self.datestart,
                                    :Location => self.location, :MaxTeams => self.maxteams, :ReplayUploads => self.replayuploads,
                                    :ReplayDownloads => self.replaydownloads, :Description => self.description, :ReturnData => self.returndata})
      self.tourneyid = response["TourneyID"] if response["Result"] == 200
      force ? response : response["Result"] == 200 ? true : false
    end

  end
  # END Class Tourney

end

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
    
    # Tourney Eigenclass
    # Eigenclass
    # ----------------
    # used to load an tourney and returns an tourney object. returns a new tourney object loaded from binarybeast.
    # Example:
    # @tourney = Binarybeast::Tourney.load(:id => "xSC21212194")
    # ----------------

    class << self
      def load(options={:force => true})
        options[:tourneyid] ? id = options[:tourneyid] : id = "xSC21212194"
        response = self.class.get("", :query => {:APIKey => self.apikey,  :APIService => "Tourney.TourneyLoad.Info", :TourneyID => self.tourneyid})
        if response["Result"] == 200
          return response if options[:force] == true
          tourney = Binarybeast::Tourney.new( :tourneyid => id,
                                              :title => response["TourneyInfo"]["Title"],
                                              :publish => response["TourneyInfo"]["Public"],
                                              :gamecode => response["TourneyInfo"]["GameCode"],
                                              :typeid => response["TourneyInfo"]["TypeID"],
                                              :elimination => response["TourneyInfo"]["Elimination"],
                                              :teammode => response["TourneyInfo"]["TeamMode"],
                                              :groupcount => response["TourneyInfo"]["GroupCount"],
                                              :teamsfromgroup => response["TourneyInfo"]["TeamsFromGroup"],
                                              :datestart => response["TourneyInfo"]["DateStart"],
                                              :location => response["TourneyInfo"]["Location"],
                                              :maxteams => response["TourneyInfo"]["MaxTeams"],
                                              :replayuploads => response["TourneyInfo"]["ReplayUploads"],
                                              :replaydownloads => response["TourneyInfo"]["ReplayDownloads"],
                                              :description => response["TourneyInfo"]["Description"],
                                              :returndata => response["TourneyInfo"]["ReturnData"])
          return tourney
        else
          return false
        end
      end
    end

    # Constructor
    # Method
    # ----------------
    # all tourney attributes can be given here. The Name parameter is needed, all else is optional.
    # Example:
    # Tourney.new(:title => "Gamkoi DevCup")
    # ----------------

    def initialize(options={:title => "Gamkoi DevTest"})
      self.tourneyid = options[:tourneyid] if options[:tourneyid]
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


    # Update
    # Method
    # ----------------
    # Pushes the attributes from the object to the binarybeast api. Pushes updates from object to Binarybeast
    # Example:
    # @tourney = Binarybeast::Tourney.new(:title => "lol")
    # @tourney.update
    # ----------------

    def update(options={:force => false})
      response = self.class.get("", :query => {:TourneyID => self.tourneyid, :APIKey => self.apikey, :APIService => "Tourney.TourneyUpdate.Settings",
                                    :Title => self.title, :Public => self.publish, :GameCode => self.gamecode,
                                    :TypeID => self.typeid, :Elimination => self.elimination,
                                    :TeamMode => self.teammode, :GroupCount => self.groupcount,
                                    :TeamsFromGroup => self.teamsfromgroup, :DateStart => self.datestart,
                                    :Location => self.location, :MaxTeams => self.maxteams, :ReplayUploads => self.replayuploads,
                                    :ReplayDownloads => self.replaydownloads, :Description => self.description, :ReturnData => self.returndata})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

    # Create
    # Method
    # ----------------
    # Creates the tournament object at binarybeast. You want to call this once after setting up your local Tourney object.
    # Example:
    # @tourney = Binarybeast::Tourny.new
    # @tourney.title = "Blabla"
    # @tourney.description = "Changing some attributes locally..."
    # @tourney.create
    # ----------------

    def create(options={:force => false})
      response = self.class.get("", :query => {:APIKey => self.apikey, :APIService => "Tourney.TourneyCreate.Create",
                                    :Title => self.title, :Public => self.publish, :GameCode => self.gamecode,
                                    :TypeID => self.typeid, :Elimination => self.elimination,
                                    :TeamMode => self.teammode, :GroupCount => self.groupcount,
                                    :TeamsFromGroup => self.teamsfromgroup, :DateStart => self.datestart,
                                    :Location => self.location, :MaxTeams => self.maxteams, :ReplayUploads => self.replayuploads,
                                    :ReplayDownloads => self.replaydownloads, :Description => self.description, :ReturnData => self.returndata})
      self.tourneyid = response["TourneyID"] if response["Result"] == 200
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

    # Delete
    # Method
    # ----------------
    # Deletes the tourney object from binarybeast. Does not delete the tourney object itself locally.
    # Example:
    # @tourney = Binarybeast::Tourney.new(:title => "Test")
    # @tourney.create
    # @tourney.delete
    # ----------------

    def delete(options={:force => false})
      response = self.class.get("", :query => {:APIKey => self.apikey, :APIService => "Tourney.TourneyDelete.Delete", :TourneyID => self.tourneyid})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

    # Start
    # Method
    # ----------------
    # Starts the object tourney on binarybeast.
    # Example:
    # @tourney = Binarybeast::Tourney.new(:title => "test")
    # @tourney.create
    # @tourney.start
    # ----------------

    def start(options={:force => false})
      options[:force] ? force = true : force = false
      options[:seeding] ? seeding = options[:seeding] : seeding = "random"
      options[:teams] ? teams = options[:teams] : teams = nil
      response = self.class.get("", :query => {:APIKey => self.apikey, :APIService => "Tourney.TourneyStart.Start", :Seeding => seeding, :Teams => teams})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

    # Load
    # Method
    # ----------------
    # Loads the information of a binarybeast tourney and saving it in the object. Pulling information - inverse of update
    # Example:
    # @tourney = Binarybeast::Tourney.new(:tourneyid => "xSC21212194")
    # @tourney.load
    # ----------------

    def load(options={:force => false})
      response = self.class.get("", :query => {:APIKey => self.apikey,  :APIService => "Tourney.TourneyLoad.Info", :TourneyID => self.tourneyid})
      return response if options[:force]
      if response["Result"] == 200
        self.title = response["TourneyInfo"]["Title"]
        self.publish = response["TourneyInfo"]["Public"]
        self.gamecode = response["TourneyInfo"]["GameCode"]
        self.typeid = response["TourneyInfo"]["TypeID"]
        self.elimination = response["TourneyInfo"]["Elimination"]
        self.teammode = response["TourneyInfo"]["TeamMode"]
        self.groupcount = response["TourneyInfo"]["GroupCount"]
        self.teamsfromgroup = response["TourneyInfo"]["TeamsFromGroup"]
        self.datestart = response["TourneyInfo"]["DateStart"]
        self.location = response["TourneyInfo"]["Location"]
        self.maxteams = response["TourneyInfo"]["MaxTeams"]
        self.replayuploads = response["TourneyInfo"]["ReplayUploads"]
        self.replaydownloads = response["TourneyInfo"]["ReplayDownloads"]
        self.description = response["TourneyInfo"]["Description"]
        self.returndata = response["TourneyInfo"]["ReturnData"]
        return true
      else
        return false
      end
    end

    # setBuilding
    # Method
    # ----------------
    # Sets the status of the tourney correlating to the object to: Status: Building
    # Example:
    # @tourney = Binarybeast::Tourney.new
    # @tourney.setBuilding
    # ----------------

    def setBuilding(options={:force => false})
      response = self.class.get("", :query => {:APIKey => self.apikey, :APIService => "Tourney.TourneySetStatus.Building", :TourneyID => self.tourneyid})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

    # setConfirmation
    # Method
    # ----------------
    # Sets the status of the tourney correlating to the object to: Status: Confirmation
    # Example:
    # @tourney = Binarybeast::Tourney.new
    # @tourney.setConfirmation
    # ----------------

    def setConfirmation(options={:force => false})
      response = self.class.get("", :query => {:APIKey => self.apikey, :APIService => "Tourney.TourneySetStatus.Confirmation", :TourneyID => self.tourneyid})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

  end
  # END Class Tourney

end

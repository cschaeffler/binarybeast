module Binarybeast
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
    attr_accessor :api_key, :id, :title, :publish, :game_code, :type_id, :elimination, :team_mode, :group_count, :teams_from_group, :date_start, :location, :max_teams, :replay_uploads, :replay_downloads, :description, :return_data
    
    # Tourney Eigenclass
    # Eigenclass
    # ----------------
    # provides some functionality in order to allow certain things before creating a tourney.
    # ----------------

    class << self
      include HTTParty
      format :json

      # Load
      # Method
      # ----------------
      # Loads a tourney from binarybeast and returns an tourney object.
      # Example:
      # @tourney = Binarybest::Tourney.load(:id => "xSC21212194")
      # ----------------

      def load(options={:force => true})
        options[:id] ? id = options[:id] : id = "xSC21212194"
        options[:force] ? force = options[:force] : force = false
        response = self.get('https://binarybeast.com/api', :query => {:APIKey => Binarybeast.api_key,  :APIService => "Tourney.TourneyLoad.Info", :id => id})
        if response["Result"] == 200
          return response if force
          tourney = Binarybeast::Tourney.new( :id => id,
                                              :title => response["TourneyInfo"]["Title"],
                                              :publish => response["TourneyInfo"]["Public"],
                                              :game_code => response["TourneyInfo"]["GameCode"],
                                              :type_id => response["TourneyInfo"]["TypeID"],
                                              :elimination => response["TourneyInfo"]["Elimination"],
                                              :team_mode => response["TourneyInfo"]["TeamMode"],
                                              :group_count => response["TourneyInfo"]["GroupCount"],
                                              :teams_from_group => response["TourneyInfo"]["TeamsFromGroup"],
                                              :date_start => response["TourneyInfo"]["DateStart"],
                                              :location => response["TourneyInfo"]["Location"],
                                              :max_teams => response["TourneyInfo"]["MaxTeams"],
                                              :replay_uploads => response["TourneyInfo"]["ReplayUploads"],
                                              :replay_downloads => response["TourneyInfo"]["ReplayDownloads"],
                                              :description => response["TourneyInfo"]["Description"],
                                              :return_data => response["TourneyInfo"]["ReturnData"],
                                              :api_key => Binarybeast.api_key)
          return tourney
        else
          return false
        end
      end
    end

    # END EIGENCLASS



    # Constructor
    # Method
    # ----------------
    # all tourney attributes can be given here. The title parameter is needed, all else is optional.
    # Example:
    # Binarybeast::Tourney.new(:title => "Gamkoi DevCup")
    # ----------------

    def initialize(options={:title => "Gamkoi DevTest"})
      self.id = options[:id] if options[:id]
      options[:title] ? self.title = options[:title] : self.title = "Test"
      options[:public] ? self.publish = options[:public] : self.publish = 0
      options[:game_code] ? self.game_code = options[:game_code] : self.game_code = ""
      options[:type_id] ? self.type_id = options[:type_id] : self.type_id = 0
      options[:elimination] ? self.elimination = options[:elimination] : self.elimination = 1
      options[:team_mode] ? self.team_mode = options[:team_mode] : self.team_mode = 1
      options[:group_count] ? self.group_count = options[:group_count] : self.group_count = 1
      options[:teams_from_group] ? self.teams_from_group = options[:teams_from_group] : self.teams_from_group = 2
      options[:date_start] ? self.date_start = options[:date_start] : self.date_start = nil
      options[:location] ? self.location = options[:location] : self.location = ""
      options[:max_teams] ? self.max_teams = options[:max_teams] : self.max_teams = 16
      options[:replay_uploads] ? self.replay_uploads = options[:replay_uploads] : self.replay_uploads = 1
      options[:replay_downloads] ? self.replay_downloads = options[:replay_downloads] : self.replay_downloads = 1
      options[:description] ? self.description = options[:description] : self.description = ""
      options[:return_data] ? self.return_data = options[:return_data] : self.return_data = 0
      options[:api_key] ? self.api_key = options[:api_key] : self.api_key = Binarybeast.api_key
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
      response = self.class.get("", :query => {:id => self.id, :APIKey => self.api_key, :APIService => "Tourney.TourneyUpdate.Settings",
                                    :Title => self.title, :Public => self.publish, :game_code => self.game_code,
                                    :type_id => self.type_id, :Elimination => self.elimination,
                                    :team_mode => self.team_mode, :group_count => self.group_count,
                                    :teams_from_group => self.teams_from_group, :date_start => self.date_start,
                                    :Location => self.location, :max_teams => self.max_teams, :replay_uploads => self.replay_uploads,
                                    :replay_downloads => self.replay_downloads, :Description => self.description, :return_data => self.return_data})
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
      response = self.class.get("", :query => {:APIKey => self.api_key, :APIService => "Tourney.TourneyCreate.Create",
                                    :Title => self.title, :Public => self.publish, :game_code => self.game_code,
                                    :type_id => self.type_id, :Elimination => self.elimination,
                                    :team_mode => self.team_mode, :group_count => self.group_count,
                                    :teams_from_group => self.teams_from_group, :date_start => self.date_start,
                                    :Location => self.location, :max_teams => self.max_teams, :replay_uploads => self.replay_uploads,
                                    :replay_downloads => self.replay_downloads, :Description => self.description, :return_data => self.return_data})
      self.id = response["TourneyID"] if response["Result"] == 200
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
      response = self.class.get("", :query => {:APIKey => self.api_key, :APIService => "Tourney.TourneyDelete.Delete", :id => self.id})
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
      response = self.class.get("", :query => {:APIKey => self.api_key, :APIService => "Tourney.TourneyStart.Start", :Seeding => seeding, :Teams => teams})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

    # Load
    # Method
    # ----------------
    # Loads the information of a binarybeast tourney and saving it in the object. Pulling information - inverse of update
    # Example:
    # @tourney = Binarybeast::Tourney.new(:id => "xSC21212194")
    # @tourney.load
    # ----------------

    def load(options={:force => false})
      response = self.class.get("", :query => {:APIKey => self.api_key,  :APIService => "Tourney.TourneyLoad.Info", :id => self.id})
      return response if options[:force]
      if response["Result"] == 200
        self.title = response["TourneyInfo"]["Title"]
        self.publish = response["TourneyInfo"]["Public"]
        self.game_code = response["TourneyInfo"]["GameCode"]
        self.type_id = response["TourneyInfo"]["TypeID"]
        self.elimination = response["TourneyInfo"]["Elimination"]
        self.team_mode = response["TourneyInfo"]["TeamMode"]
        self.group_count = response["TourneyInfo"]["GroupCount"]
        self.teams_from_group = response["TourneyInfo"]["TeamsFromGroup"]
        self.date_start = response["TourneyInfo"]["DateStart"]
        self.location = response["TourneyInfo"]["Location"]
        self.max_teams = response["TourneyInfo"]["MaxTeams"]
        self.replay_uploads = response["TourneyInfo"]["ReplayUploads"]
        self.replay_downloads = response["TourneyInfo"]["ReplayDownloads"]
        self.description = response["TourneyInfo"]["Description"]
        self.return_data = response["TourneyInfo"]["ReturnData"]
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
      response = self.class.get("", :query => {:APIKey => self.api_key, :APIService => "Tourney.TourneySetStatus.Building", :id => self.id})
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
      response = self.class.get("", :query => {:APIKey => self.api_key, :APIService => "Tourney.TourneySetStatus.Confirmation", :id => self.id})
      options[:force] ? response : response["Result"] == 200 ? true : false
    end

  end
  # END Class Tourney
end
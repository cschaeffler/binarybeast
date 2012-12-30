module BinaryBeast
  # Tourney
  # Class
  # ---------------
  # This is the Tourney service class. It will be used to most. It gives you a brand new Tourney object to call methods on.
  # Example:
  # tourney = Binarybeast::Tourney.new("Gamkoi Test")
  # ---------------
  # gives you a tourney object
  
  class Tournament < BinaryBeast::Service

    attr_accessor :api_key, :id, :tourney_id, :title, :public, :display_name, :url,
      :game_code, :game, :game_style, :game_icon,
      :status, :type_id, :elimination, :teams_confirmed_count, :teams_joined_count,
      :team_mode, :teams_from_group, :max_teams, :group_count,
      :view_count, :date_start, :location,
      :replay_uploads, :replay_downloads,
      :description, :return_data


    # Default values for each attribute
    DEFAULTS = {
      :id               => nil,
      :title            => 'Gamkoi DevTest', #"BinaryBeast API Ruby (#{BinaryBeast::VERSION}) Test Tournament",
      :game_code        => 'misc',
      :game             => 'Misc.',
      :type_id          => BinaryBeast::TOURNAMENT_TYPE_BRACKETS,
      :elimination      => BinaryBeast::ELIMINATION_SINGLE,
      :team_mode        => 1,
      :group_count      => 1,
      :teams_from_group => 2, 
      :date_start       => Time.new.strftime("%Y-%m-%d"),
      :location         => '',
      :max_teams        => 16,
      :replay_uploads   => BinaryBeast::REPLAY_UPLOADS_OPTIONAL,
      :replay_downloads => BinaryBeast::REPLAY_DOWNLOADS_ENABLED,
      :description      => nil,
      :return_data      => 0,
    }

    # Tourney Eigenclass
    # Eigenclass
    # ----------------
    # provides some functionality in order to allow certain things before creating a tourney.
    # ----------------

    class << self

      # Load
      # Method
      # ----------------
      # Loads a tourney from binarybeast and returns an tourney object.
      # Example:
      # @tourney = Binarybest::Tourney.load(:id => "xSC21212194")
      # ----------------

      def load(options={:force => false, :id => 'xSC21212194'})
        
        #Use this test tournament as a default value for now
        id = options[:id] || options[:tourney_id] || 'xSC21212194'

        BinaryBeast.call('Tourney.TourneyLoad.Info', :tourney_id => id) do |response|

          return false if response['result'] != 200
          return response if options[:force]

          return BinaryBeast::Tournament.new(response['tourney_info'])
          
        end 

      end



      # List
      # Method
      # ----------------
      # Loads the List of Tourneys you've created. Returns an array if successful, else false
      # Example:
      # @tourneylist = BinaryBeast::Tourney.list
      # ----------------

      def list(options={:order => 'date_start'})
        BinaryBeast.call('Tourney.TourneyList.Creator', {:order => 'date_start'}.merge(options)) do |response|
          return response if options[:force]
          return false if response['result'] != 200

          # return an array of initialized tournaments instead of just the raw data, unless asked otherwise          
          return response['list'].map do |tourney|
            BinaryBeast::Tournament.new(tourney)
          end
  
        end
        # end Tourney.TourneyList.Popular
  
      end
  
      # ListPopular
      # Method
      # ----------------
      # Loads the List of Popular Tourneys. Retuns an hash if successful, else false
      # Example:
      # @tourneylist = Binarybeast::Tourney.listpopular
      # ----------------
  
      def listPopular(options={:limit => 30})
  
        BinaryBeast.call('Tourney.TourneyList.Popular', {:limit => 3}.merge(options)) do |response|
          return false if response['result'] != 200
          return response if options[:force]
  
          # return an array of initialized tournaments instead of just the raw data, unless asked otherwise          
          return response['list'].map do |tourney|
            BinaryBeast::Tournament.new(tourney)
          end
  
        end
        # end Tourney.TourneyList.Popular
  
      end
      # end listPopular

    end
    # END EIGENCLASS



    # Constructor
    # Method
    # ----------------
    # all tourney attributes can be given here. The title parameter is needed, all else is optional.
    # Example:
    # Binarybeast::Tourney.new(:title => "Gamkoi DevCup")
    # ----------------

    def initialize(options={})
      # Merge the default values and assign all values locally using the base serice classes attribute assigner, saves loads of typing :)
      options[:id] = options[:id] || options['id'] || options[:tourney_id] || options['tourney_id']
      assignAttributes(Tournament::DEFAULTS.merge(options))
    end


    # Update
    # Method
    # ----------------
    # Pushes the attributes from the object to the binarybeast api. Pushes updates from object to Binarybeast
    # Example:
    # @tourney = Binarybeast::Tourney.new(:title => "lol")
    # @tourney.title = 'New Title!'
    # @tourney.update
    # ----------------

    def update(options={:force => false})
      response = BinaryBeast.call('Tourney.TourneyUpdate.Settings', getAttributes.merge({:tourney_id => self.id}) )
      options[:force] ? response : response['result'] == 200 ? true : false
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
      response = BinaryBeast.call('Tourney.TourneyCreate.Create', getAttributes)
      self.id = response['tourney_id'] if response['result'] == 200
      options[:force] ? response : response['result'] == 200 ? true : false
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
      response = BinaryBeast.call('Tourney.TourneyDelete.Delete', :tourney_id => self.id)
      options[:force] ? response : response['result'] == 200 ? true : false
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

      response = BinaryBeast.call('Tourney.TourneyStart.Start', {
        :tourney_id => self.id,
        :seeding => BinaryBeast::SEEDING_RANDOM
      }.merge(options))

      options[:force] ? response : response['result'] == 200 ? true : false

      
    end

    # Load
    # Method
    # ----------------
    # Loads the information of a binarybeast tourney and saving it in the object. Pulling information - inverse of update
    # Example:
    # @tourney = Binarybeast::Tourney.new(:id => 'xSC21212194')
    # @tourney.load
    # ----------------

    def load(options={:force => false})
      
      response = BinaryBeast.call('Tourney.TourneyLoad.Info', {:tourney_id => self.id}.merge(options))

      return response if options[:force]      
      return false if response['result']
      
      self.assignAttributes(response['tourney_info'])
      return true
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
      response = BinaryBeast.call('Tourney.TourneySetStatus.Building', :tourney_id => self.id)
      options[:force] ? response : response['result'] == 200 ? true : false
    end


    # setConfirmation
    # Method
    # ----------------
    # Sets the status of the tourney correlating to the object to: Status: Confirmation
    # Example:
    # @tourney = BinaryBeast::Tourney.new
    # @tourney.setConfirmation
    # ----------------

    def setConfirmation(options={:force => false})
      response = BinaryBeast.call('Tourney.TourneySetStatus.Confirmation', :tourney_id => self.id)
      options[:force] ? response : response['result'] == 200 ? true : false
    end

  end
  # END Class Tournament
end
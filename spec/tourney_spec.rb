require 'spec_helper'

describe BinaryBeast::Tournament do
  before :all do
    @tournament = BinaryBeast::Tournament.new(:title => 'Gamkoi DevTest Ruby', :description => 'This is a tourney created via the Gamkoi.com ruby gem.', :game_code => 'HotS')
  end
  describe "eigenclass" do
    describe "list" do
      it "should return array of tourneys" do
        response = BinaryBeast::Tournament.list
        response.should be_instance_of Array
      end
    end
    describe "listPopular" do
      it "should return list of popular tourneys" do
        response = BinaryBeast::Tournament.listPopular
        response.should be_instance_of Array
      end
    end
    describe "load" do
      it "should load from eigenclass" do
        tournament = BinaryBeast::Tournament.load(:id => @tournament.tourney_id)
        tournament.should be_an_instance_of BinaryBeast::Tournament
        tournament.title.should eq('Gamkoi DevTest Ruby')
      end
    end
  end
  describe "new" do
    it "takes one to all parameters and returns an tourney object" do
      @tournament.should be_an_instance_of BinaryBeast::Tournament
    end
    it "should respond to title" do
      @tournament.title.should eq('Gamkoi DevTest Ruby')
    end
    it "should respond to description" do
      @tournament.description.should eq('This is a tourney created via the Gamkoi.com ruby gem.')
    end
    it "should respond to all attributes" do
      @tournament.should respond_to(:title)
      @tournament.should respond_to(:id)
      @tournament.should respond_to(:public)
      @tournament.should respond_to(:game_code)
      @tournament.should respond_to(:type_id)
      @tournament.should respond_to(:elimination)
      @tournament.should respond_to(:team_mode)
      @tournament.should respond_to(:group_count)
      @tournament.should respond_to(:teams_from_group)
      @tournament.should respond_to(:date_start)
      @tournament.should respond_to(:location)
      @tournament.should respond_to(:max_teams)
      @tournament.should respond_to(:replay_uploads)
      @tournament.should respond_to(:replay_downloads)
      @tournament.should respond_to(:description)
      @tournament.should respond_to(:return_data)
      @tournament.should respond_to(:api_key)
    end
  end
  describe "create" do
    it "should respond to publish" do
      @tournament.should respond_to(:public)
    end
    it "should return parsed json array" do
      @tournament.create.should eq(true)
    end
    it "should return forced broadcast" do
      response = @tournament.create(:force => true)
      response['result'].should eq(200)
      response.should be_instance_of Hash
    end
  end
  describe "update" do
    it "should respond to update" do
      @tournament.should respond_to(:update)
      response = @tournament.update(:force => true)
      response.should be_instance_of Hash
    end
  end
  describe "delete" do
    it "should respond to delete" do
      @tournament.should respond_to(:delete)
    end
    it "should delete the tourney" do
      tournament = BinaryBeast::Tournament.new(:title => "Delete Test")
      tournament.create
      response = tournament.delete(:force => true)
      response.should be_instance_of Hash
    end
  end
  describe "start" do
    it "should respond to start" do
      @tournament.should respond_to(:start)
    end
    it "should start the tourney" do
      #@tournament.start
      #@tournament.load
      #@tournament.status.should eq('Active')
    end
  end
  describe "load" do
    it "should respond to load" do
      @tournament.should respond_to(:load)
    end
    it "should load a tourney and set attributes" do
      tournament = BinaryBeast::Tournament.load(:id => @tournament.tourney_id)
      tournament.load
      tournament.title.should eq("Gamkoi DevTest Ruby")
    end
  end
  describe "set status" do
    it "should respond to building" do
      @tournament.should respond_to(:setBuilding)
    end
    it "should respond to confirmation" do
      @tournament.should respond_to(:setConfirmation)
    end
  end
end
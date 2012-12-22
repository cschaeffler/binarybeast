require 'spec_helper'

describe Binarybeast::Tourney do
  before :all do
    @tourney = Binarybeast::Tourney.new(:title => "Gamkoi DevTest Ruby", :description => "This is a tourney created via the Gamkoi.com ruby gem.")
  end
  describe "load" do
    it "should load from eigenclass" do
      tourney = Binarybeast::Tourney.load(:tourneyid => "xSC21212194")
      tourney.should be_an_instance_of Binarybeast::Tourney
    end
  end
  describe "new" do
    it "takes one to all parameters and returns an tourney object" do
      @tourney.should be_an_instance_of Binarybeast::Tourney
    end
    it "should respond to title" do
      @tourney.title.should eq("Gamkoi DevTest Ruby")
    end
    it "should respond to description" do
      @tourney.description.should eq("This is a tourney created via the Gamkoi.com ruby gem.")
    end
    it "should respond to all attributes" do
      @tourney.should respond_to(:title)
      @tourney.should respond_to(:tourneyid)
      @tourney.should respond_to(:publish)
      @tourney.should respond_to(:gamecode)
      @tourney.should respond_to(:typeid)
      @tourney.should respond_to(:elimination)
      @tourney.should respond_to(:teammode)
      @tourney.should respond_to(:groupcount)
      @tourney.should respond_to(:teamsfromgroup)
      @tourney.should respond_to(:datestart)
      @tourney.should respond_to(:location)
      @tourney.should respond_to(:maxteams)
      @tourney.should respond_to(:replayuploads)
      @tourney.should respond_to(:replaydownloads)
      @tourney.should respond_to(:description)
      @tourney.should respond_to(:returndata)
      @tourney.should respond_to(:apikey)
    end
  end
  describe "update" do
    it "should respond to update" do
      @tourney.should respond_to(:update)
      response = @tourney.update(:force => true)
      response.should be_instance_of Hash
    end
  end
  describe "create" do
    it "should respond to publish" do
      @tourney.should respond_to(:publish)
    end
    it "should return parsed json array" do
      @tourney.create.should eq(true)
    end
    it "should return forced broadcast" do
      response = @tourney.create(:force => true)
      response["Result"].should eq(200)
      response.should be_instance_of Hash
    end
  end
  describe "delete" do
    it "should respond to delete" do
      @tourney.should respond_to(:delete)
    end
    it "should delete the tourney" do
      tourney = Binarybeast::Tourney.new(:title => "Delete Test")
      tourney.create
      response = tourney.delete(:force => true)
      response.should be_instance_of Hash
    end
  end
  describe "start" do
    it "should respond to start" do
      @tourney.should respond_to(:start)
    end
    it "should start the tourney" do
    end
  end
  describe "load" do
    it "should respond to load" do
      @tourney.should respond_to(:load)
    end
    it "should load a tourney and set attributes" do
      tourney = Binarybeast::Tourney.new(:tourneyid => "xSC21212194")
      tourney.load
      tourney.title.should eq("Gamkoi Dev Dummy")
    end
  end
  describe "set status" do
    it "should respond to building" do
      @tourney.should respond_to(:setBuilding)
    end
    it "should respond to confirmation" do
      @tourney.should respond_to(:setConfirmation)
    end
  end
end
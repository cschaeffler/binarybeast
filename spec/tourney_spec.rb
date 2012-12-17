require 'spec_helper'

describe Binarybeast::Tourney do
  before :each do
    @tourney = Binarybeast::Tourney.new(:title => "Gamkoi DevTest Ruby", :description => "This is a tourney created via the Gamkoi.com ruby gem.")
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
    end
  end
  describe "broadcast" do
    it "should respond to publish" do
      @tourney.should respond_to(:publish)
    end
    it "should return parsed json array" do
      @tourney.broadcast.should eq(true)
    end
    it "should return forced broadcast" do
      response = @tourney.broadcast(true)
      response["Result"].should eq(200)
    end
  end
end
require 'spec_helper'

describe BinaryBeast::Team do
	before :all do
		@tourney = BinaryBeast::Tournament.load(:id => 'xSC21212194')
	end
	describe "Tournament.loadTeams" do
		it "should load teams of tourney" do
			@tourney.loadTeams
			@tourney.should respond_to(:teams)
			@tourney.teams.should be_instance_of Array
			@tourney.teams[1].should be_instance_of BinaryBeast::Team
		end
	end
	describe "should respond to" do
		it "attributes" do
			@tourney.teams[1].should respond_to(:tourney_team_id)
			@tourney.teams[1].should respond_to(:display_name)
			@tourney.teams[1].should respond_to(:country_code)
		end
	end
end
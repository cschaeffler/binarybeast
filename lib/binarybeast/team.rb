module BinaryBeast
	class Team < BinaryBeast::Service
		attr_accessor :id, :tourney_team_id, :user_id, :status, :display_name, :invoice_id, :notes, :player_count,
						:network_display_name, :country, :country_code, :country_code_short, :wins, :lb_wins, :draws,
						:player_password, :country_flag, :position, :bronze_wins, :spoiler_wins, :spoiler_lb_wins

		def initialize(options={})
			options[:id] = options[:id] || options['id'] || options[:tourney_team_id] || options['tourney_team_id']
			assignAttributes(options)
		end

		def insert; end;

		def update; end;

		def list; end;

		def getOpponent; end;

		def reportWin; end;

		def confirm; end;

		def unconfirm; end;

		def ban; end;

		def delete; end;

		class << self
			def load(options={:force => false, :id => 'xSC21212194'})
				id = options[:id] || options[:tourney_team_id] || 'xSC21212194'
				BinaryBeast.call('Tourney.TourneyLoad.Team', :tourney_team_id => id) do |response|
					return false if response["result"] != 200
					return response if options[:force]
					return BinaryBeast::Team.new(response["team_info"])
				end
			end
		end

	end
end
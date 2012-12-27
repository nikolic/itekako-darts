require 'spec_helper'

describe "StaticPages" do
	subject { page }

	url_helpers = Rails.application.routes.url_helpers

	path_maps = {
		url_helpers.root_path => "Home Page",
		url_helpers.players_path => "Players",
		url_helpers.game_mode_path => "Game Mode",
		url_helpers.participants_path => "Participants",
		url_helpers.positioning_path => "Positioning",
		url_helpers.results_path => "Results"
	}

	path_maps.each do |path, title|
		describe "Visiting path " + path do
			before do
				visit path
			end

			it { should have_selector 'title', :text => title }
		end
	end
end
require 'spec_helper'

describe "StaticPages" do
  subject { page }

  # url_helpers = Rails.application.routes.url_helpers

  # path_maps = {
  #   url_helpers.root_path => "Home Page",
  #   url_helpers.players_path => "Players",
  #   url_helpers.game_mode_path => "Game Mode",
  #   url_helpers.participants_path => "Participants",
  #   url_helpers.positioning_path => "Positioning",
  #   url_helpers.results_path => "Results"
  # }

  # path_maps.each do |path, title|
  #   describe "Visiting path " + path do
  #     before do
  #       visit path
  #     end

  #     it { should have_selector 'title', :text => title }
  #   end
  # end

  shared_examples_for "all_static_pages" do
    it { should have_selector 'title', text: heading }
  end

  describe "Home Page" do
    before do
      visit root_path
    end
    let(:heading) {"Home Page"}

    it_should_behave_like "all_static_pages"
  end

  describe "Game Options Page" do
    before do
      visit options_path
    end

    let(:heading) {"Game Options"}
    it_should_behave_like "all_static_pages"
  end
end
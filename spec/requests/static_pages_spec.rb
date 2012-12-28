require 'spec_helper'

describe "StaticPages" do
<<<<<<< HEAD
=======

>>>>>>> 83c774229f1cccf1dcf242ab9a0b4b159de9471c
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

<<<<<<< HEAD
  shared_examples_for "all_static_pages" do
    it { should have_selector 'title', text: heading }
  end

=======
  #******************************************************************************
  # Shared Tests
  #******************************************************************************

  shared_examples_for "all_static_pages" do
    it { should have_selector 'title', :text => heading }
  end

  #******************************************************************************
  # Home Page Test
  #******************************************************************************

>>>>>>> 83c774229f1cccf1dcf242ab9a0b4b159de9471c
  describe "Home Page" do
    before do
      visit root_path
    end
    let(:heading) {"Home Page"}

    it_should_behave_like "all_static_pages"
  end

<<<<<<< HEAD
=======
  #******************************************************************************
  # Game Options Page Test
  #******************************************************************************

>>>>>>> 83c774229f1cccf1dcf242ab9a0b4b159de9471c
  describe "Game Options Page" do
    before do
      visit options_path
    end

    let(:heading) {"Game Options"}
    it_should_behave_like "all_static_pages"
<<<<<<< HEAD
=======

    describe "list of players" do
      before(:all) { 10.times { FactoryGirl.create(:player) } }
      after(:all)  { Player.delete_all }

      it "should list all players" do
        Player.all.each do |player|
          should have_selector 'li', :text => player.name
        end
      end

      it "should list doubles/singles radio button" do
        should have_selector 'input', :type => "radio"
        should have_selector 'label', :text => "Doubles"

        should have_selector 'input', :type => "radio"
        should have_selector 'label', :text => "Singles"
      end

      it "should have 'Start Game' link" do
      	should have_selector 'input', :value => 'Start Game'
      end
    end
  end

  #******************************************************************************
  # Results Page Test
  #******************************************************************************

  describe "Results Page" do
    before do
      visit results_path
    end

    let(:heading) {"Results"}
    it_should_behave_like "all_static_pages"

    it "should have link back to 'Home Page'" do
      should have_link 'Done', :href => root_path
    end
>>>>>>> 83c774229f1cccf1dcf242ab9a0b4b159de9471c
  end
end
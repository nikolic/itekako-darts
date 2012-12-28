# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participation do
    player_id 1
    game_id 1
    position 1
    team 1
  end
end

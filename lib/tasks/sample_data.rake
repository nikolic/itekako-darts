namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_players
  end
end

def make_players
  10.times do |n|
    name  = Faker::Name.name
    Player.create!(name: name)
  end
end
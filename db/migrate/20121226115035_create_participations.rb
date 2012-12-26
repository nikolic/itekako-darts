class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.int :player_id
      t.int :game_id
      t.int :position

      t.timestamps
    end
  end
end

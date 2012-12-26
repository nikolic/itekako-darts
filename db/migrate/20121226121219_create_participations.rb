class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :position

      t.timestamps
    end
  end
end

class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :player
      t.integer :game
      t.integer :position
      t.integer :team
      t.references :player
      t.references :game
      t.timestamps
    end
  end
end

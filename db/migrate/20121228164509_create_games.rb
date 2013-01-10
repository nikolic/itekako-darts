class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :coeficient_id
      t.integer :number_of_players
      t.boolean :doubles
      t.references :coeficient
      t.timestamps
    end
  end
end

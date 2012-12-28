class CreateCoeficients < ActiveRecord::Migration
  def change
    create_table :coeficients do |t|
      t.integer :value
      t.boolean :active
      t.timestamps
    end
  end
end

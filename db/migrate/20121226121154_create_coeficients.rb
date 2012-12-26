class CreateCoeficients < ActiveRecord::Migration
  def change
    create_table :coeficients do |t|
      t.integer :value

      t.timestamps
    end
  end
end

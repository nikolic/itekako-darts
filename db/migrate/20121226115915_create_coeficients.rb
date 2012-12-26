class CreateCoeficients < ActiveRecord::Migration
  def change
    create_table :coeficients do |t|
      t.int :value

      t.timestamps
    end
  end
end

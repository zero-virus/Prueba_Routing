class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone, :unique => true
      t.string :email, :unique => true
      t.integer :max_stops
      t.timestamps
    end
  end
end

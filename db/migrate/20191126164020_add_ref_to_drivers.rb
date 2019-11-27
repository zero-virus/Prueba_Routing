class AddRefToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_reference :drivers, :vehicle, null: true, foreign_key: true, default: nil, :unique => true
  end
end

class AddRefToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_reference :vehicles, :driver, null: true, foreign_key: true, default: nil, :unique => true
  end
end

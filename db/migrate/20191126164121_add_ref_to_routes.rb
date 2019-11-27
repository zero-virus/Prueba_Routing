class AddRefToRoutes < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :vehicle, null: true, foreign_key: true, default:nil
  end
end

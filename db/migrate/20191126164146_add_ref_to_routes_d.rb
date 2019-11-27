class AddRefToRoutesD < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :driver, null: true, foreign_key: true, default: nil
  end
end

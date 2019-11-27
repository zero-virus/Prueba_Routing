class AddArrayToRoute < ActiveRecord::Migration[6.0]
  def change
    add_column :routes, :cities, :text, default: [].to_yaml
  end
end

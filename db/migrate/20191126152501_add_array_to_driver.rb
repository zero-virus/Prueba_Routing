class AddArrayToDriver < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :cities, :text, default: [].to_yaml
  end
end

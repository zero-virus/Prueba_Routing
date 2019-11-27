class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.datetime  :start_at
      t.datetime  :ends_at
      t.string    :load_type
      t.float     :load_sum
      t.integer   :stop_amount
      t.timestamps
    end
  end
end

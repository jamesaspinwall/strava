class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :athlete
      t.string :location
      t.integer :start_ts
      t.float :distance
      t.integer :moving
      t.integer :stopped
      t.float :speed
      t.float :watts
      t.float :calories
      t.float :kj

      t.timestamps
    end
  end
end

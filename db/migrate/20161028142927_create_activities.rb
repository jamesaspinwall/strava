class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :location
      t.integer :activity_start
      t.integer :distance
      t.integer :hr
      t.integer :hr_max
      t.integer :moving
      t.integer :stop
      t.integer :speed
      t.integer :watts
      t.integer :calories
      t.integer :kj

      t.timestamps
    end
  end
end

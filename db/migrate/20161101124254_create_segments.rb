class CreateSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :segments do |t|
      t.string :name
      t.float :distance
      t.float :grade
      t.float :grade_max
      t.float :high
      t.float :low
      t.string :start_location
      t.string :end_location

      t.timestamps
    end
  end
end

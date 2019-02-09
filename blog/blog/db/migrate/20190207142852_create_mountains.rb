class CreateMountains < ActiveRecord::Migration[5.2]
  def change
    create_table :mountains do |t|
      t.string :name
      t.text :description
      t.integer :altitude
      t.integer :visits_count

      t.timestamps
    end
  end
end

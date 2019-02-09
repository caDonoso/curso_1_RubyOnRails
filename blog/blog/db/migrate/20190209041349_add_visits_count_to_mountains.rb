class AddVisitsCountToMountains < ActiveRecord::Migration[5.2]
  def change
    add_column :mountains, :visits_count, :integer
  end
end

class AddColumnStateToMountains < ActiveRecord::Migration[5.2]
  def change
  	remove_foreign_key :mountains, :state
    add_column :mountains, :state, :string, default: "in_draft"
    add_foreign_key :mountains, :state
  end
end

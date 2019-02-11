class AddUserIdToMountains < ActiveRecord::Migration[5.2]
  def change
    add_reference :mountains, :user, index: true
    add_foreign_key :mountains, :users
  end
end

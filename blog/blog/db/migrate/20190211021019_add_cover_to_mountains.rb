class AddCoverToMountains < ActiveRecord::Migration[5.2]
  def change
  	add_attachment :mountains,:cover
  end
end

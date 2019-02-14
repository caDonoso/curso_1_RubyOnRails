class AddColumnMarkupDescriptionToMountains < ActiveRecord::Migration[5.2]
  def change
    add_column :mountains, :markup_body, :text
  end
end

class AddPhotosToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :photo_id, :string
  end
end

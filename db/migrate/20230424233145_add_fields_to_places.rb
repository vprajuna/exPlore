class AddFieldsToPlaces < ActiveRecord::Migration[6.1]
  def change
    add_column :places, :business_id, :string, unique: true
    add_column :places, :address, :string
    add_column :places, :city, :string
    add_column :places, :state, :string
    add_column :places, :postal_code, :string
    add_column :places, :stars, :float
    add_column :places, :reviews, :integer
    add_column :places, :categories, :string
  end
end

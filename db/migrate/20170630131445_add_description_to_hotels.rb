class AddDescriptionToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :description, :text
  end
end

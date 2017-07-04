class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.belongs_to :hotel

      t.timestamps
    end
  end
end

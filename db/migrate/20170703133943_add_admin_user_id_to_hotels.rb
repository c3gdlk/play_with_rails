class AddAdminUserIdToHotels < ActiveRecord::Migration
  def change

    add_column :hotels, :admin_user_id, :integer
  end
end

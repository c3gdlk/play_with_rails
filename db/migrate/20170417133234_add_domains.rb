class AddDomains < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url
      t.timestamps
    end

    create_table :emails do |t|
      t.integer :site_id
      t.string :email
    end

    add_index :emails, [:site_id, :email], unique: true
  end
end

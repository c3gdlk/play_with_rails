class AddCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
    end

    create_table :categories_posts do |t|
      t.belongs_to :post
      t.belongs_to :category

      t.timestamps
    end
  end
end

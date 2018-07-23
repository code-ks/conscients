class AddCategoryToBlogPost < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :category, :string
  end
end

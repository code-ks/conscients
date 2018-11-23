class AddTitleToBlogPost < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_posts, :title, :string
  end
end

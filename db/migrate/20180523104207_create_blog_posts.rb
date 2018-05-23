class CreateBlogPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_posts do |t|
      t.string :title_fr
      t.string :title_en
      t.text :body
      t.string :slug
      t.integer :position

      t.timestamps
    end
  end
end

class CreateBlogPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_posts do |t|
      t.text :content
      t.string :slug
      t.string :seo_title
      t.string :meta_description
      t.boolean :published_fr, default: false, null: false
      t.boolean :published_en, default: false, null: false
      t.integer :position

      t.timestamps
    end
  end
end

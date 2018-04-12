# frozen_string_literal: true

Category.destroy_all
SubCategory.destroy_all

categories_name = %w[Bébés Enfants Cadeaux]
sub_categories_name = %w[Vêtements Livres Others]
gift_sub_categories_name = ['Cadeaux de Naissance', 'Cadeau anniversaire', 'Cadeau de mariage']

categories_name.each do |category_name|
  category = Category.create!(name: category_name)
  if category_name != 'Cadeaux'
    sub_categories_name.each do |sub_category_name|
      SubCategory.create!(name: sub_category_name, category: category)
    end
  else
    gift_sub_categories_name.each do |sub_category_name|
      SubCategory.create!(name: sub_category_name, category: category)
    end
  end
end

Rails.logger.info "#{Category.all.count} categories created"
Rails.logger.info "#{SubCategory.all.count} sub_categories created"
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end

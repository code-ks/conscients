# == Schema Information
#
# Table name: product_tree_plantations
#
#  id                 :bigint(8)        not null, primary key
#  product_id         :bigint(8)
#  tree_plantation_id :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (tree_plantation_id => tree_plantations.id)
#

class ProductTreePlantation < ApplicationRecord
  belongs_to :product
  belongs_to :tree_plantation
end

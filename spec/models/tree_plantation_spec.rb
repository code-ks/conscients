# frozen_string_literal: true

require 'rails_helper'

# RSpec.configure do |c|
#   c.use_transactional_examples = false
#   c.order = "defined"
# end

RSpec.describe TreePlantation, type: :model do
  include_context 'When authenticated'
  fixtures :tree_plantations
  it 'is has a tree quantities equal to base quantity at creation' do
    tree_plantation = tree_plantations(:amaz_fondacion)

    expect(tree_plantation.trees_quantity).to eq(100)
  end

  it 'is is decremented when a line item is a tree' do
    # @user = create(:client, password: 'password', password_confirmation: 'password')
    create(:order, client: Client.last)
  end
end

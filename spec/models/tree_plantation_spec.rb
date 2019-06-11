# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TreePlantation, type: :model do
  it 'is has a tree quantities equal to base quantity at creation' do
    tree_plantation = build(:tree_plantation)
    expect(tree_plantation.trees_quantity).to eq(100)
  end

  it 'is is decremented when a line item is a tree' do
  end
end

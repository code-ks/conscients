# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'generally' do
    it 'is has a default status of in-cart' do
      order = build(:order)
      expect(order.aasm_state).to eq('in_cart')
    end

    it 'transitions from to status waiting_for_bank_transfer when order_by_bank_transfer!' do
      order = build(:order)
      order.order_by_bank_transfer!
      expect(order.aasm_state).to eq('waiting_for_bank_transfer')
    end
  end
end

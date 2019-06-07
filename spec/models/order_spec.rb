# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  fixtures :orders
  context 'generally' do
    it 'is has a default status of in-cart' do
      order = Order.create!
      expect(order.aasm_state).to eq('in_cart')
    end

    it 'transitions from to status waiting_for_bank_transfer when order_by_bank_transfer!' do
      order = orders(:default)
      order.order_by_bank_transfer!
      expect(order.aasm_state).to eq('waiting_for_bank_transfer')
    end
  end
end

# frozen_string_literal: true

class PagesController < HighVoltage::PagesController
  def home
    send_data Order.first.invoice.download, filename: 'test.pdf', type: :pdf
  end
end

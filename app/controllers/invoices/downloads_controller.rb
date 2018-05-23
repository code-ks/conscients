# frozen_string_literal: true

class Invoices::DownloadsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    send_data(@order.invoice.download, disposition: 'attachment', filename: "invoice##{@order.id}")
  end
end

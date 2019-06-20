# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :redirect_if_unsigned, only: :show

  def show
    @markers = current_client.markers
    @orders = current_client.orders.finished.order_by_date.includes \
      :delivery_address, :line_items, :invoice_attachment
    @line_items = current_client.line_items.certificated
    @quantity_of_trees_planted = current_client.quantity_of_trees_planted
    @tonne_co2_captured = current_client.tonne_co2_captured
  end
end

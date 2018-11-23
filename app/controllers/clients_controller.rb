# frozen_string_literal: true

class ClientsController < ApplicationController
  def show
    @markers = current_client.markers
  end
end

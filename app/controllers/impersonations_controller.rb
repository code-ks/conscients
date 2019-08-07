# frozen_string_literal: true

class ImpersonationsController < ApplicationController
  before_action :authenticate_client!, :verify_if_can_debug

  def index
    @clients = Client.order(email: :desc)
  end

  def impersonate
    client = Client.find(params[:id])
    impersonate_client(client)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_client
    redirect_to root_path
  end

  private

  def verify_if_can_debug
    redirect_to root_path unless true_client.can_debug || current_client.can_debug
  end
end

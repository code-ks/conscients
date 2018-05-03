# frozen_string_literal: true

class Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_client

  def facebook
    if @client.persisted?
      sign_in_and_redirect @client, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_client_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def set_client
    @client = Client.from_facebook_oauth(request.env['omniauth.auth'])
  end
end

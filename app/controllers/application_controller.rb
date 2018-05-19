require 'application_responder'

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :set_locale, :set_category, :set_cart, :set_current_visit
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :track_action

  private

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def set_category
    @category = params[:category_id] ? Category.find(params[:category_id]) : Category.home
  end

  def set_cart
    begin
      @cart = Order.in_cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Order.create(client: current_client)
      session[:cart_id] = @cart.id
    end
    @cart.update(client: current_client) if !@cart.client && current_client
  end

  def set_current_visit
    Current.visit = current_visit
  end

  def track_action
    ahoy.track 'Action', request.path_parameters
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:newsletter_subscriber])
  end
end

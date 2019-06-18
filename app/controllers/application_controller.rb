require 'application_responder'

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found?
  rescue_from ActionController::UnknownFormat, with: :record_not_found? if Rails.env.production?

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :set_locale, :set_category, :set_cart, :set_current_visit
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Analytics
  after_action :track_action

  private

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale).to_sym
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def set_category
    @current_category = params[:category_id] ? Category.find(params[:category_id]) : Category.home
  end

  # Set current cart with session[:cart_id]
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
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[password password_confirmation current_password])
  end

  def record_not_found?
    # rubocop:disable Style/AndOr
    flash[:alert] = I18n.t('flash.record_not_found')
    redirect_to root_path and return
    # rubocop:enable Style/AndOr
  end

  def redirect_if_unsigned
    redirect_to root_path, notice: t('flash.clients.show.notice') and return unless current_client
  end
end

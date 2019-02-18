# frozen_string_literal: true

class Clients::RegistrationsController < DeviseInvitable::RegistrationsController
  protected

  def after_update_path_for(_resource)
    clients_path
  end
end

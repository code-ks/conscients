# frozen_string_literal: true

class ProfileEmailsController < ProfilesController
  def update
    if current_client.update(client_params)
      redirect_to clients_path, notice: t('profiles.edit.successfull_update')
    else
      errors = current_client.errors.full_messages.join(', ')
      redirect_to clients_path, notice: "#{t('profiles.edit.unsuccessfull_update')}: #{errors}"
    end
  end

  private

  def client_params
    params.require(:client).permit(:email)
  end
end

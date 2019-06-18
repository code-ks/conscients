# frozen_string_literal: true

class ProfileEmailsController < ProfilesController
  def update
    if current_client.update(client_params)
      redirect_to edit_profile_path, notice: t('profiles.edit.successfull_update')
    else
      redirect_to edit_profile_path, notice: t('profiles.edit.unsuccessfull_update')
    end
  end

  private

  def client_params
    params.require(:client).permit(:email)
  end
end

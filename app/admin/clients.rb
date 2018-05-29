# frozen_string_literal: true

ActiveAdmin.register Client do
  menu parent: I18n.t('active_admin.client_management')

  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :phone_number,
                :newsletter_subscriber

  form do |f|
    f.semantic_errors
    inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :newsletter_subscriber
    end
    f.actions
  end
end

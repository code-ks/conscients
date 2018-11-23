# frozen_string_literal: true

ActiveAdmin.register Address do
  menu parent: I18n.t('active_admin.client_management')

  permit_params :first_name, :last_name, :company, :address_1, :address_2, :city,
                :zip_code, :country, :title, :address_type, :email, :client_id, :postal_address_type
end

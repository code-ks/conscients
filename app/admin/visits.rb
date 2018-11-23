# frozen_string_literal: true

ActiveAdmin.register Ahoy::Visit do
  menu parent: I18n.t('active_admin.client_management')

  includes :client

  actions :index, :show
end

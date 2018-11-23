# frozen_string_literal: true

ActiveAdmin.register Ahoy::Event do
  menu parent: I18n.t('active_admin.client_management')

  includes :visit, :client

  actions :index, :show
end

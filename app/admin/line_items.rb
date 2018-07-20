# frozen_string_literal: true

ActiveAdmin.register LineItem do
  menu parent: I18n.t('active_admin.order_management')

  permit_params :product_sku_id, :order_id, :ttc_price_cents, :ttc_price_currency,
                :tree_plantation_id, :quantity, :recipient_name, :recipient_message,
                :certificate_date, :certificate_number, :delivery_email

  includes :order, :tree_plantation, :product_sku

  action_item :download_certificate, only: :show, if: proc { line_item.certificate.attached? } do
    link_to t('.download_certificate'),
            download_certificate_admin_line_item_path(line_item), method: :put
  end

  member_action :download_certificate, method: :put do
    send_data(resource.certificate.download, disposition: 'attachment',
              filename: "certificate##{resource.id}")
  end
end

# frozen_string_literal: true

class ClientMailer < ApplicationMailer
  def bank_account_details
    @order = params[:order]
    attachments['bank_account_details_conscients.jpg'] =
      File.read(Rails.root.join('app', 'assets', 'images', 'bank_account_details_conscients.jpg'))
    mail to: @order.client_email
  end

  def order_confirmation
    @order = params[:order]
    attachments['invoice.pdf'] = @order.invoice.download
    @order.line_items.certificable.each do |line_item|
      attachments["certificate##{line_item.id}.pdf"] = line_item.certificate.download
    end
    mail to: @order.client_email
  end

  def order_fulfillment
    @order = params[:order]
    mail to: @order.client_email
  end
end

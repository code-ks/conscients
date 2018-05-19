# frozen_string_literal: true

class ClientMailer < ApplicationMailer
  def bank_account_details
    @order = params[:order]
    attachments['bank_account_details_conscients.jpg'] =
      File.read(Rails.root.join('app', 'assets', 'images', 'bank_account_details_conscients.jpg'))
    mail to: @order.client_email
  end
end

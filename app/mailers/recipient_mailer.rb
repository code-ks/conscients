# frozen_string_literal: true

class RecipientMailer < ApplicationMailer
  def gift_certificate
    @line_item = params[:line_item]
    attachments['certificate.pdf'] = @line_item.certificate.download
    mail to: @line_item.delivery_email
  end
end

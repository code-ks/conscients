# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def contact_message
    @message = params[:message]
    @name = params[:name]
    @email = params[:email]
    mail from: 'contact@conscients.com',
         to: 'carole@conscients.com', subject: params[:subject]
  end

  def stock_alert
    @message = params[:message]
    mail from: 'contact@conscients.com',
         to: 'carole@conscients.com',
         subject: params[:subject]
  end

  def line_items_csv
    file_name = "line_items_export-#{Time.zone.today.strftime('%F')}.csv"
    attachments[file_name] = { mime_type: 'text/csv', content: params[:csv] }
    mail from: 'contact@conscients.com',
         to: 'carole@conscients.com',
         subject: 'Line items csv export before carts cleanup'
  end
end

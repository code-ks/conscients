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
end

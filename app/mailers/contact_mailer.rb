# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def contact_message
    @message = params[:message]
    mail from: %("#{params[:name]}" <#{params[:email]}>),
         to: 'carole@conscients.com', subject: params[:subject]
  end
end

# frozen_string_literal: true

class ContactsController < ApplicationController
  invisible_captcha only: :create, honeypot: :profession

  def create
    send_contact_email
    flash[:notice] = t('flash.contact.create.notice')
    redirect_to page_path(id: 'contact')
  end

  def send_contact_email
    ContactMailer.with(name: params['contact_name'], email: params['contact_email'],
                       subject: params['contact_subject'], message: params['contact_message'])
                 .contact_message.deliver_later
  end
end

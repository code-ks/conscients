# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'carole@conscients.com'
  layout 'mailer'
end

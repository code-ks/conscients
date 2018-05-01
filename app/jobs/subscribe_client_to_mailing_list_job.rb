# frozen_string_literal: true

class SubscribeClientToMailingListJob < ApplicationJob
  queue_as :default

  def perform(list_id, client_id)
    client = Client.find(client_id)
    Gibbon::Request.lists(list_id)
                   .members(client.lower_case_md5_hashed_email)
                   .upsert(body: { email_address: client.email.downcase, status: 'subscribed' })
  end
end

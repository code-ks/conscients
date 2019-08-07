# frozen_string_literal: true

# For newsletter form in home (not signed up users)
class NewsletterSubscriptionsController < ApplicationController
  def create
    if Rails.env.production?
      list_id = I18n.locale == :fr ? '53e2a5b32b' : 'fde901016c'
      add_to_list(list_id)
      flash[:notice] = t('flash.newsletter_subscription.create.notice')
    else
      flash[:alert] = t('flash.newsletter_subscription.create.alert')
    end
    redirect_to root_path(anchor: 'form_for_newsletter')
  end

  private

  def add_to_list
    Gibbon::Request.lists(list_id)
                   .members(Digest::MD5.hexdigest(params['email'].downcase))
                   .upsert(body:
                        { email_address: params['email'].downcase, status: 'subscribed' })
  end
end

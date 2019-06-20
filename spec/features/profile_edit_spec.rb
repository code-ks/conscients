# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Profile Edit', type: :feature, js: true do
  # include_context 'With home category'
  # include_context 'When authenticated'

  # scenario 'A signed in user can update his email' do
  #   client = FactoryBot.create(:client, email: 'old@gmail.com', password: 'password')
  #   login_as(client, scope: :client)

  #   visit '/profile/edit'
  #   fill_in('client_email', with: 'new@gmail.com')
  #   click_on('update-email-btn')

  #   # save_and_open_screenshot
  #   expect(page).to have_selector("#client_email[value='new@gmail.com']")
  #   expect(client.email).to eq('new@gmail.com')
  # end

  # scenario 'A signed in user can update his password' do
  #   client = FactoryBot.create(:client, email: 'new@gmail.com', password: 'password')
  #   login_as(client, scope: :client)
  #   # client = FactoryBot.create(:client, email: 'new@gmail.com', password: 'password')
  #   # login_as(client, scope: :client)

  #   visit '/profile/edit'
  #   save_and_open_screenshot
  #   fill_in('client_current_password', with: 'password')
  #   fill_in('client_password', with: 'newpassword')
  #   save_and_open_screenshot
  #   click_on('update-pwd-btn')

  #   save_and_open_screenshot
  #   expect(page).to have_selector('h1', text: 'Éditer mon compte')
  #   expect(client.valid_password?('newpassword')).to be true
  # end

  # scenario 'A user can not update his password if his current_password is wrong' do
  #   visit '/profile/edit'
  #   fill_in('client_current_password', with: 'passwordx')
  #   fill_in('client_password', with: 'newpassword')
  #   click_on('update-pwd-btn')

  #   expect(page).to have_selector('h1', text: 'Éditer mon compte')
  #   expect(current_client.valid_password?('newpassword')).to be false
  # end

  # scenario 'A user can not update his password if his current_password is blank' do
  #   visit '/profile/edit'
  #   fill_in('client_password', with: 'newpassword')
  #   click_on('update-pwd-btn')

  #   expect(page).to have_selector('h1', text: 'Éditer mon compte')
  #   expect(current_client.valid_password?('newpassword')).to be false
  # end

  # def authenticate
  #   client = create(:client, email: 'user@example.com', password: 'password')
  #   login_as(client, scope: :client)

  #   # visit '/clients/sign_in'
  #   # within('.sign-up-box') do
  #   #   fill_in 'client_email', with: 'user@example.com'
  #   #   fill_in 'client_password', with: 'password'
  #   # end
  #   # click_button 'Créer mon compte'
  # end
end

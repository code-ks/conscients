# frozen_string_literal: true

RSpec.shared_context 'When authenticated' do
  background do
    authenticate
  end

  def authenticate
    visit '/clients/sign_in'
    within('.sign-up-box') do
      fill_in 'client_email', with: 'user@example.com'
      fill_in 'client_password', with: 'password'
    end
    click_button 'Créer mon compte'
  end
end

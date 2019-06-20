# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Profile Edit Navigation', type: :feature, js: true do
  include_context 'With home category'
  include_context 'When authenticated'

  scenario 'A user can not access the profile edit page unless signed_in' do
    visit '/profile/edit'
    expect(page).to have_selector('h1', text: 'Éditer mon compte')
  end
end

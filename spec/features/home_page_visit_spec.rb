# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home Page Visit', type: :feature do
  include_context 'With home category'
  scenario 'A user can visit the home page' do
    visit '/'
    # save_and_open_screenshot
    expect(page).to have_text('Conscients & ses cadeaux écolos vous souhaite la')
  end
end

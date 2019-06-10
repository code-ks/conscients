# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home Page Visit', type: :feature do
  fixtures :categories
  scenario 'A user can visit the home page' do
    visit '/'
    # save_and_open_screenshot
    # click_button "Create Widget"

    expect(page).to have_text('Conscients & ses cadeaux écolos vous souhaite la')
  end
end

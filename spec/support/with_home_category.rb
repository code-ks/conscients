# frozen_string_literal: true

RSpec.shared_context 'With home category' do
  background do
    setup_home_category
  end

  def setup_home_category
    create(:category)
  end
end

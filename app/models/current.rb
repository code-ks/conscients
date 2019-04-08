# frozen_string_literal: true

# Used rails 5.2 current everything. Needed to go to last category visited
class Current < ActiveSupport::CurrentAttributes
  attribute :visit
end

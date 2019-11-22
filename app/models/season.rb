# frozen_string_literal: true

class Season < Content
  validates :number, presence: true
end

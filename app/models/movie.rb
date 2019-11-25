# frozen_string_literal: true

class Movie < Content
  scope :ordered_by_creation, -> { order(created_at: :desc) }
end

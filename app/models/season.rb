# frozen_string_literal: true

class Season < Content
  has_many :episodes, foreign_key: :content_id

  validates :number, presence: true
end

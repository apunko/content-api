# frozen_string_literal: true

class Season < Content
  has_many :episodes, -> { order(number: :asc) }, foreign_key: :content_id

  validates :number, presence: true
end

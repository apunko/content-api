# frozen_string_literal: true

class Content < ApplicationRecord
  validates :title, presence: true
  validates :plot, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :number }

  scope :ordered_by_creation, -> { order(created_at: :desc) }
end

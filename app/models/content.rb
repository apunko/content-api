# frozen_string_literal: true

class Content < ApplicationRecord
  validates :title, presence: true
  validates :plot, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :number }
end

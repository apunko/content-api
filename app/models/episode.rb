# frozen_string_literal: true

class Episode < ApplicationRecord
  belongs_to :season, foreign_key: :content_id

  validates :title, presence: true
  validates :plot, presence: true
  validates :number, presence: true
end

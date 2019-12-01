# frozen_string_literal: true

class User < ApplicationRecord
  has_many :purchases, -> { order(created_at: :desc) }

  validates :email, format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :email, uniqueness: true

  scope :ordered_by_creation, -> { order(created_at: :desc) }
end

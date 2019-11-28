# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :email, uniqueness: true
end

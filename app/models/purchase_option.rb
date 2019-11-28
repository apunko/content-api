# frozen_string_literal: true

class PurchaseOption < ApplicationRecord
  belongs_to :content

  validates :quality, inclusion: { in: %w[HD SD] }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end

# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_option do
    content

    quality { %w[HD SD].sample }
    price { Faker::Number.between(from: 1, to: 10_000) }
  end
end

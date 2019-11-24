# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    title { Faker::Lorem.unique.word }
    plot  { Faker::Lorem.sentence }
    number { Faker::Number.digit }
  end
end

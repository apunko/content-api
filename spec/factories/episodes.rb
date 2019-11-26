# frozen_string_literal: true

FactoryBot.define do
  factory :episode do
    season
    title { Faker::Lorem.word }
    plot { Faker::Lorem.sentence }
    number { Faker::Number.digit + 1 }
  end
end

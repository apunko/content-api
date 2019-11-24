# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    plot  { Faker::Lorem.sentence }
  end
end

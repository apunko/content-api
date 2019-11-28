# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.unique.word }
    plot  { Faker::Lorem.sentence }

    transient do
      purchase_options_count { Faker::Number.digit }
    end

    after(:create) do |movie, evaluator|
      create_list(:purchase_option, evaluator.purchase_options_count, content: movie)
    end
  end
end

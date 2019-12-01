# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    factory :user_with_purchases do
      transient do
        purchases_count { Faker::Number.digit }
      end

      after(:create) do |user, evaluator|
        create_list(:purchase, evaluator.purchases_count, user: user)
      end
    end
  end
end

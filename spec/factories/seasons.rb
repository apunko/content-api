# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    title { Faker::Lorem.unique.word }
    plot  { Faker::Lorem.sentence }
    number { Faker::Number.non_zero_digit }

    transient do
      purchase_options_count { Faker::Number.digit }
    end

    after(:create) do |season, evaluator|
      create_list(:purchase_option, evaluator.purchase_options_count, content: season)
    end

    factory :season_with_episodes do
      transient do
        episodes_count { Faker::Number.digit }
        purchase_options_count { Faker::Number.digit }
      end

      after(:create) do |season, evaluator|
        create_list(:episode, evaluator.episodes_count, season: season)
        create_list(:purchase_option, evaluator.purchase_options_count, content: season)
      end
    end
  end
end

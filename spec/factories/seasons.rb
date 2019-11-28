# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    title { Faker::Lorem.unique.word }
    plot  { Faker::Lorem.sentence }
    number { Faker::Number.non_zero_digit }

    factory :season_with_episodes do
      transient do
        episodes_count { Faker::Number.digit }
      end

      after(:create) do |season, evaluator|
        create_list(:episode, evaluator.episodes_count, season: season)
      end
    end
  end
end

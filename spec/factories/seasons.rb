# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    title { Faker::Lorem.unique.word }
    plot  { Faker::Lorem.sentence }
    number { Faker::Number.digit + 1 }

    # user_with_posts will create post data after the user has been created
    factory :season_with_episodes do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        episodes_count { Faker::Number.digit }
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |season, evaluator|
        create_list(:episode, evaluator.episodes_count, season: season)
      end
    end
  end
end

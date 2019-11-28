# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    title { Faker::Lorem.unique.word }
    plot  { Faker::Lorem.sentence }
    type { Faker::Boolean.boolean ? 'Season' : 'Movie' }

    after(:create) do |content, _|
      if content.type == 'Season'
        content.update(number: Faker::Number.non_zero_digit)
        create_list(:episode, Faker::Number.digit, season: Season.find(content.id))
      end
    end
  end
end

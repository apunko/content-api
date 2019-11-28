# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    title { "#{Faker::Lorem.word}_#{Faker::Number.number(digits: 10)}" }
    plot  { Faker::Lorem.sentence }
    type { %w[Season Movie].sample }

    after(:create) do |content, _|
      if content.type == 'Season'
        content.update(number: Faker::Number.non_zero_digit)
        create_list(:episode, Faker::Number.digit, season: Season.find(content.id))
      end
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    user
    purchase_option
  end
end

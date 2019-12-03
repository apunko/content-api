# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    user
    content
    expired { false }
    after(:build) do |purchase|
      purchase.purchase_option = create(:purchase_option, content: purchase.content)
    end
  end
end

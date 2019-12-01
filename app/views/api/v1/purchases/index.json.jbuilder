# frozen_string_literal: true

json.data do
  json.array! @purchases do |purchase|
    json.id purchase.id
    json.content purchase.content, partial: 'api/v1/contents/content', as: :content
    json.created_at purchase.created_at
  end
end

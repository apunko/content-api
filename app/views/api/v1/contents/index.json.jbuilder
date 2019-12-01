# frozen_string_literal: true

json.data do
  json.array! @contents, partial: 'api/v1/contents/content', as: :content
end

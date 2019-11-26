# frozen_string_literal: true

json.data do
  json.array! @movies do |movie|
    json.id movie.id
    json.title movie.title
    json.plot movie.plot
    json.number movie.number
    json.created_at movie.created_at
  end
end

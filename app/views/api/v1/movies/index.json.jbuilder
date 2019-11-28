# frozen_string_literal: true

json.data do
  json.array! @movies do |movie|
    json.id movie.id
    json.title movie.title
    json.plot movie.plot
    json.number movie.number
    json.created_at movie.created_at
    json.purchase_options do
      json.partial! 'api/v1/purchase_options/purchase_options', purchase_options: movie.purchase_options
    end
  end
end

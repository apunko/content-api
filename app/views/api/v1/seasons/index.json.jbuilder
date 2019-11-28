# frozen_string_literal: true

json.data do
  json.array! @seasons do |season|
    json.id season.id
    json.title season.title
    json.plot season.plot
    json.number season.number
    json.created_at season.created_at
    json.episodes do
      json.partial! 'api/v1/episodes/episodes', episodes: season.episodes
    end
  end
end

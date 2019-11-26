# frozen_string_literal: true

json.data do
  json.array! @seasons do |season|
    json.id season.id
    json.title season.title
    json.plot season.plot
    json.number season.number
    json.created_at season.created_at
    json.episodes do
      json.array! season.episodes do |episode|
        json.id episode.id
        json.title episode.title
        json.plot episode.plot
        json.number episode.number
        json.created_at episode.created_at
      end
    end
  end
end

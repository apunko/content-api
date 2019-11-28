# frozen_string_literal: true

json.data do
  json.array! @contents do |content|
    json.id content.id
    json.type content.type
    json.title content.title
    json.plot content.plot
    json.number content.number if content.type == 'Season'
    json.created_at content.created_at
    if content.type == 'Season'
      json.episodes do
        json.array! content.episodes do |episode|
          json.id episode.id
          json.title episode.title
          json.plot episode.plot
          json.number episode.number
          json.created_at episode.created_at
        end
      end
    end
  end
end

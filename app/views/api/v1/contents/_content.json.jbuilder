# frozen_string_literal: true

json.id content.id
json.type content.type
json.title content.title
json.plot content.plot
json.number content.number if content.type == 'Season'
json.created_at content.created_at
json.purchase_options do
  json.partial! 'api/v1/purchase_options/purchase_options', purchase_options: content.purchase_options
end
if content.type == 'Season'
  json.episodes do
    json.partial! 'api/v1/episodes/episodes', episodes: content.episodes
  end
end

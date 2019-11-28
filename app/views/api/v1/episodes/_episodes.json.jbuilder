json.array! episodes do |episode|
  json.id episode.id
  json.title episode.title
  json.plot episode.plot
  json.number episode.number
  json.created_at episode.created_at
end

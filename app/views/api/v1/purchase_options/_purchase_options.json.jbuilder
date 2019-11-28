# frozen_string_literal: true

json.array! purchase_options do |option|
  json.id option.id
  json.quality option.quality
  json.price option.price.to_f / 100
end

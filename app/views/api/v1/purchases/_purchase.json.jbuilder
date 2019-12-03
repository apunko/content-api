# frozen_string_literal: true

json.data do
  json.id @purchase.id
  json.user_id @purchase.user_id
  json.purchase_option_id @purchase.purchase_option_id
  json.created_at @purchase.created_at
end

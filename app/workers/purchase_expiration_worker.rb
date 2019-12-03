# frozen_string_literal: true

class PurchaseExpirationWorker
  include Sidekiq::Worker

  def perform(purchase_id)
    purchase = Purchase.find(purchase_id)

    purchase.update(expired: true) if purchase && jid == purchase.expiration_jid
  end
end

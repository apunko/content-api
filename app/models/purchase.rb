# frozen_string_literal: true

class Purchase < ApplicationRecord
  WATCH_TIME = 2.days

  belongs_to :user
  belongs_to :purchase_option
  has_one :content, through: :purchase_option
  has_many :episodes, through: :content

  scope :for_user_library, lambda { |user_id|
    where(user_id: user_id, created_at: Purchase::WATCH_TIME.ago..DateTime.now.utc).includes(:content, :episodes)
  }
end

# frozen_string_literal: true

class Purchase < ApplicationRecord
  WATCH_TIME = 2.days

  belongs_to :user
  belongs_to :purchase_option
  belongs_to :content, touch: true
  has_many :episodes, through: :content

  after_create :schedule_expiration_job
  after_save :invalidate_cache

  validates :user, presence: true
  validates :purchase_option, presence: true
  validates :content, presence: true

  scope :for_user_library, lambda { |user_id|
    where(user_id: user_id, expired: false).includes(:content, :episodes).order(created_at: :asc)
  }

  private

  def schedule_expiration_job
    return if expired

    job_id = PurchaseExpirationWorker.perform_in(WATCH_TIME, id)
    update(expiration_jid: job_id)
  end

  def invalidate_cache
    Rails.cache.delete_matched("purchases_user_#{user_id}")
  end
end

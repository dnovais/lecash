class Offer < ApplicationRecord
  include AASM

  validates :advertiser_name, :url, :description, :starts_at, presence: true
  validates :advertiser_name, uniqueness: true
  validates :url, url: true
  validates :description, length: { maximum: 500 }

  aasm :column => 'state' do
    state :disabled, initial: true
    state :enabled

    event :enable_offer do
      transitions from: :disabled, to: :enabled
    end

    event :disable_offer do
      transitions from: :enabled, to: :disabled
    end
  end

  def ready_to_start?
    starts_at <= today && (ends_at >= today || ends_at.blank?)
  end

  def finished?
    return if ends_at.blank?
    today > ends_at
  end

  def not_expires?
    ends_at.blank?
  end

  private

  def today
    Time.now.utc
  end
end

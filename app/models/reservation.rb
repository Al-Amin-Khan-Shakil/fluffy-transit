class Reservation < ApplicationRecord
  belongs_to :service
  belongs_to :user

  validates :pickup_address, :drop_address, :description, :contact, :pickup_date, :client_name, :pet_amount,
            presence: true
  validate :pet_amount, numericality: { greater_than: 0 }
  validate :pickup_date_cannot_be_in_the_past

  private

  def pickup_date_cannot_be_in_the_past
    return unless pickup_date.present? && pickup_date < Date.today

    errors.add(:pickup_date, "Date can't be in the past")
  end
end

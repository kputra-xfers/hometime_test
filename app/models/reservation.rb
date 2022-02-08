class Reservation < ApplicationRecord
  belongs_to :guest

  validates :code, uniqueness: true, presence: true
  validate :start_date_is_today_or_after
  validate :end_date_is_after_start_date

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?
  
    if end_date < start_date
      errors.add(:end_date, "cannot be before the start date")
    end 
  end

  def start_date_is_today_or_after
    return if start_date.blank?

    if start_date < Time.now
      errors.add(:start_date, "cannot be before today")
    end
  end
end

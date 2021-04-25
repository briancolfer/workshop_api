class Workshop < ApplicationRecord
  has_and_belongs_to_many :people
  validates :workshop_name, presence: true, length: { minimum: 5}, uniqueness: true
  validates :description, length: { minimum: 10 }

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end

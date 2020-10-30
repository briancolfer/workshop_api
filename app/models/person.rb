class Person < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 1}
  validates :last_name, presence: true, length: { minimum: 1}

  validates :birth_date, presence: true
  validate :validate_age

  private

  def validate_age
    if  birth_date.present? && birth_date >= Date.today
      errors.add(:birth_date, 'Must be older than today')
    end
  end

end

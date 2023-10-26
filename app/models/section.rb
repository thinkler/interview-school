class Section < ApplicationRecord
  MIN_DURATION = 30
  MAX_DURATION = 90
  WEEKDAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  belongs_to :subject
  belongs_to :teacher
  belongs_to :classroom

  scope :by_weekday_intersection, ->(weekdays) { where("array_to_string(weekdays, '')::bit(7) & ?::bit(7) != ?::bit(7)", weekdays.join(''), '0000000') }
  scope :by_time_intersection, ->(start_time, end_time) { where('start_time < ? AND end_time > ?', end_time, start_time) }

  # Not a big fan of before callbacks and rails validations
  # In perfrect case - use validator per operation Create/Update
  validate :valdiate_save

  def formatted_weekdays
    weekdays.each_with_index.map { |day, index| WEEKDAYS[index] if day == 1 }.compact.join(', ')
  end

  private

  def valdiate_save
    errs = Validations::SaveSection.new(self).call
    self.errors.add(:base, errs) if errs.present?
  end
end

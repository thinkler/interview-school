class Section < ApplicationRecord
  MIN_DURATION = 30
  MAX_DURATION = 120
  WEEKDAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  belongs_to :subject
  belongs_to :teacher
  belongs_to :classroom

  scope :by_weekday_intersection, ->(weekdays) { where('weekdays::bit(7) & ?::bit(7) != ?::bit(7)', weekdays, '0000000') }

  def formatted_weekdays
    weekdays.each_with_index.map { |day, index| WEEKDAYS[index] if day == 1 }.compact.join(', ')
  end
end

class Section < ApplicationRecord
  WEEKDAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  belongs_to :subject
  belongs_to :teacher
  belongs_to :classroom

  def formatted_weekdays
    weekdays.each_with_index.map { |day, index| WEEKDAYS[index] if day == 1 }.compact.join(', ')
  end
end

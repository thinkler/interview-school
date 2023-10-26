class Validations::EnrollSection
  # Could be part of i8n file
  ERRORS = {
    time_occupied: 'The student already has section at this time'
  }

  attr_reader :section
  delegate :start_time, :end_time, :weekdays, to: :section

  def initialize(student, section)
    @student = student
    @section = section
    @errors = []
  end

  # Errors could be filled with extra info like intersections time etc
  def call
    validate_sections_intersection

    @errors
  end

  private

  def validate_sections_intersection
    weekdays_intersections = @student.sections.by_weekday_intersection(weekdays)
    return if weekdays_intersections.empty?

    time_intersections = weekdays_intersections.by_time_intersection(start_time, end_time)
    @errors << ERRORS[:time_occupied] if time_intersections.present?
  end
end

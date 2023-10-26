class Validations::CreateSection
  # Could be part of i8n file
  ERRORS = {
    unrelated_subject: 'Teacher is not related to subject',
    teacher_occupied: 'Teacher is occupied at this time',
    end_time_later: 'End time should be later than start time',
    duration_short: "Duration can't be shorter than #{Section::MIN_DURATION} minutes",
    duration_long: "Duration can't be longer than #{Section::MAX_DURATION} minutes",
  }

  attr_reader :section
  delegate :teacher, :subject, :start_time, :end_time, :weekdays, to: :section

  def intialize(section)
    @section = section
    @errors = []
  end

  def call
    validate_teacher_subject
    validate_teacher_occupation
    validate_duration
    validate_time_consistency

    @errors
  end

  private

  def validate_teacher_subject
    @errors << ERRORS[:unrelated_subject] unless teacher.subjects.include?(subject)
  end

  def validate_teacher_occupation
    weekdays_sections_intersects = teacher.sections.by_weekday_intersection
    return if weekdays_sections_intersects.empty?

    time_sections_intersects = weekdays_sections_intersects.where('start_time < ? AND end_time > ?', end_time, start_time)
    @errors << ERRORS[:teacher_occupied] if time_sections_intersects.present?
  end

  def validate_duration
    @errors << ERRORS[:duration_short] if end_time - start_time < Section::MIN_DURATION
    @errors << ERRORS[:duration_long] if end_time - start_time > Section::MAX_DURATION
  end

  def validate_time_consistency
    @errors << ERRORS[:end_time_later] if end_time <= start_time
  end
end


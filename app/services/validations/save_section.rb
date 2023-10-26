class Validations::SaveSection
  # Could be part of i8n file
  ERRORS = {
    unrelated_subject: 'Teacher is not related to subject',
    teacher_occupied: 'Teacher is occupied at this time',
    classroom_occupied: 'Classroom is occupied at this time',
    end_time_later: 'End time should be later than start time',
    duration_short: "Duration can't be shorter than #{Section::MIN_DURATION} minutes",
    duration_long: "Duration can't be longer than #{Section::MAX_DURATION} minutes",
    invalid_weekdays: 'Invalid weekdays'
  }

  attr_reader :section
  delegate :classroom, :teacher, :subject, :start_time, :end_time, :weekdays, to: :section

  def initialize(section)
    @section = section
    @errors = []
  end

  # Errors could be filled with extra info like intersections time etc
  def call
    validate_duration
    validate_time_consistency
    validate_weekdays

    if teacher
      validate_teacher_subject
      validate_teacher_occupation
    end

    if classroom
      vadlidate_classroom_occupation
    end

    @errors
  end

  private

  def validate_teacher_subject
    @errors << ERRORS[:unrelated_subject] unless teacher.subjects.include?(subject)
  end

  # 2 methods are identical and could be moved to shared module/util class
  # + the same in Validations::EnrollSection
  def vadlidate_classroom_occupation
    weekdays_intersects = classroom.sections.where.not(id: section).by_weekday_intersection(weekdays)
    return if weekdays_intersects.empty?

    time_intersects = weekdays_intersects.by_time_intersection(start_time, end_time)
    @errors << ERRORS[:classroom_occupied] if time_intersects.present?
  end

  def validate_teacher_occupation
    scope = teacher.sections.where.not(id: section)

    weekdays_intersects = teacher.sections.where.not(id: section).by_weekday_intersection(weekdays)
    return if weekdays_intersects.empty?

    time_intersects = weekdays_intersects.by_time_intersection(start_time, end_time)
    @errors << ERRORS[:teacher_occupied] if time_intersects.present?
  end

  def validate_duration
    mins_duration = (end_time - start_time) / 60
    @errors << ERRORS[:duration_short] if mins_duration < Section::MIN_DURATION
    @errors << ERRORS[:duration_long] if mins_duration > Section::MAX_DURATION
  end

  def validate_time_consistency
    @errors << ERRORS[:end_time_later] if end_time <= start_time
  end

  def validate_weekdays
    return @errors << ERRORS[:invalid_weekdays] if weekdays.size != 7
    return @errors << ERRORS[:invalid_weekdays] if weekdays.any? { |day| day != 0 && day != 1 }
  end
end


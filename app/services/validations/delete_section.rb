# Not implemented
class Validations::DeleteSection
  # Could be part of i8n file
  ERRORS = {
    unrelated_subject: 'Teacher is not related to subject',
  }

  attr_reader :section
  delegate :teacher, :subject, :start_time, :end_time, :weekdays, to: :section

  def initialize(section)
    @section = section
    @errors = []
  end

  def call
    # - Today is not a previous day of the next section week day Validation

    @errors
  end

  private
end

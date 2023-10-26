class StudentSection < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validate :validate_save

  private

  def validate_save
    errs = Validations::EnrollSection.new(student, section).call
    self.errors.add(:base, errs) if errs.present?
  end
end

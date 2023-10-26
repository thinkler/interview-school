class ApplicationController < ActionController::Base
  before_action :authenticate_student

  def authenticate_student
    @current_student = Student.find_by(id: session[:current_student_id])
  end
end

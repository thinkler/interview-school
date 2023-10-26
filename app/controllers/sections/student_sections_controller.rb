class Sections::StudentSectionsController < ApplicationController
  def create
    @st_sec = StudentSection.create(student_id: params[:student_id], section_id: params[:section_id])

    if @st_sec.save
      redirect_to sections_path, notice: 'Successfully enrolled.'
    else
      redirect_to sections_path, alert: @st_sec.errors.full_messages.join(', ')
    end
  end

  def destroy
    @st_sec = StudentSection.find_by(student_id: params[:student_id], section_id: params[:section_id])

    if @st_sec.destroy
      redirect_to sections_path, notice: 'Successfully unrolled.'
    else
      redirect_to sections_path, alert: @st_sec.errors.full_messages.join(', ')
    end
  end
end

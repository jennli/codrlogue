# == Schema Information
#
# Table name: educations
#
#  id          :integer          not null, primary key
#  school_name :string
#  school_link :string
#  grade_year  :datetime
#  level       :string
#  field       :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EducationsController < ApplicationController
before_action :find_education, only: [:show, :edit, :update, :destroy]

  def new
    @education = Education.new
  end

  def create
    @education = Education.new education_params
    @education.user = current_user
    respond_to do |format|
      if @education.save
        format.js { render :education_create_success }
      else
        format.js { render :education_create_failure }
      end
    end
  end

  def index
    @educations = current_user.educations
  end

  def show
    respond_to do |format|
      format.json { render json: @education.to_json }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @education.update education_params
        format.json { render json: @education.to_json }
      else
        format.json { render json: @education.errors }
      end
    end
  end

  def destory
    @education.user = current_user
    @education.destroy
    respond_to do |format|
      format.json { render :education_destroy }
    end
  end

  private

  def find_education
    @education = Education.find params[:id]
  end

  def education_params
    params.require(:education).permit(:school_name,:school_link,:grade_year,:level,:field)
  end
end

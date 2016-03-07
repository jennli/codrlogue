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
  autocomplete :education, :school_name
  before_action :find_education, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  def new
    @education = Education.new
  end

  def create
    @education = Education.new education_params
    @education.user = current_user
    #@education.school_link = sanitize_url(@education.school_link)
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
    respond_to do |format|
      format.js { render :education_edit }
    end
  end

  def update
    respond_to do |format|
      if @education.update education_params
        format.js { render :education_update_success }
      else
        format.js { render :education_update_failure }
      end
    end
  end

  def destroy
    @education.user = current_user
    @education.destroy
    respond_to do |format|
      format.js { render :education_destroy }
    end
  end

  private

  def find_education
    @education = Education.find params[:id]
  end

  def education_params
    params[:education][:school_link] = sanitize_url(params[:education][:school_link])
    params.require(:education).permit(:school_name,:school_link,:grade_year,:level,:field)
  end

  def authorize_user
    unless can? :manage, @education
      redirect_to root_path , alert: "Access Denied"
    end
  end
end

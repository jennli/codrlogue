# == Schema Information
#
# Table name: employments
#
#  id         :integer          not null, primary key
#  job_title  :string
#  location   :string
#  start_year :datetime
#  end_year   :datetime
#  summary    :text
#  user_id    :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EmploymentsController < ApplicationController
  before_action :find_employment, only: [:update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]
  before_action :check_if_user_signed_in

  ### Employments are created, updated, and destroyed here. ###

  def create
    @employment = Employment.new(employment_params)
    @employment.user = current_user
    respond_to do |format|
      if @employment.save
        format.js { render :employment_create_success }
      else
        format.js { render :employment_create_failure}
      end
    end
  end

  def update
    respond_to do |format|
      if @employment.update(employment_params)
        format.js { render :employment_update_success }
      else
        format.js { render :employment_update_failure}
      end
    end
  end

  def destroy
    @employment.destroy
    respond_to do |format|
      format.js { render :employment_destroy }
    end
  end

  private
    def find_employment
      @employment = Employment.find(params[:id])
    end

    def employment_params
      params.require(:employment).permit(
        :job_title,
        :location,
        :start_year,
        :end_year,
        :summary,
        :user_id,
        :company_id
      )
    end

    def authorize_user
      unless can? :manage, @employment
        redirect_to root_path , alert: "Access Denied"
      end
    end

  end

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
  autocomplete :employment, :company_name
  before_action :find_employment, only: [:update, :destroy, :edit]
  before_action :authorize_user, only: [:update, :destroy]
  before_action :check_if_user_signed_in

  ### Employments are created, updated, and destroyed here. ###

  def create
    @employment = Employment.new(employment_params)
    @employment.user = current_user
    # go through the params, see if the company already exists, and if it doesn't create it, then associate the employment with the company
    #@company = Company.where(name: params.employment.companies.name) || Company.create(name: params.employment.companies.name)
    #@employment.company = @company

    respond_to do |format|
    if @employment.save
        format.js { render :employment_create_success }
      else
        format.js { render :employment_create_failure }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render :employment_edit }
    end
  end

  def update
    respond_to do |format|
      if @employment.update(employment_params)
        format.js { render :employment_update_success }
      else
        format.js { render :employment_update_failure }
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
      params[:employment][:company_link] = sanitize_url(params[:employment][:company_link])
      params.require(:employment).permit(
        :job_title,
        :location,
        :start_year,
        :end_year,
        :summary,
        :user_id,
        :company_name,
        :company_link
      )
    end

    def authorize_user
      unless can? :manage, @employment
        redirect_to root_path , alert: "Access Denied"
      end
    end

  end

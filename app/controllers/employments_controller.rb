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
  before_action :set_employment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @employments = Employment.all
  end

  def show
  end

  def new
    @employment = Employment.new
  end

  def edit
  end

  def create
    @employment = Employment.new(employment_params)
    @employment.user = current_user
    if @employment.save
      redirect_to @employment, notice: 'Employment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @employment.update(employment_params)
      redirect_to @employment, notice: 'Employment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employment.destroy
    redirect_to root_path, notice: 'Employment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @employment = Employment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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

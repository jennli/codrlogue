# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CompaniesController < ApplicationController

  ##################### RENAME/REMOVE THIS ###############
  before_action :set_company, only: [:show, :library_show]
  ##################### RENAME/REMOVE THIS ###############

  before_action :authenticate_user, except: [:index, :show]

  # Index for companies not needed. Company information only applies to User/Student show page
  # def index
  #   @companies = Company.all
  #   ###################### UPDATE ACTIVERECORD SEARCH CRITERIA ######################
  #   @employments = Employment.where("priv_snippet=?", false)
  #   ###################### UPDATE ACTIVERECORD SEARCH CRITERIA ######################
  # end


  def show
    ###################### UPDATE ACTIVERECORD SEARCH CRITERIA ######################
    @employments = Employment.where("company_id=? AND priv_snippet=?", params[:id], false)
    ###################### UPDATE ACTIVERECORD SEARCH CRITERIA ######################
  end

  def new # A way for the user to add new companies
    @company = Company.new
  end

  def create # Action to create new companies
    @company = Company.new company_params
    if @company.save
      redirect_to root_path, notice: "New company added"
    else
      render :new
    end
  end
  ##################### RENAME/REMOVE THIS ###############
  def library_index
  ##################### RENAME/REMOVE THIS ###############
    @companies = Company.all
  end

  ##################### RENAME/REMOVE THIS ###############
  def library_show
  ##################### RENAME/REMOVE THIS ###############
    @employments = Employment.where("company_id=? AND user_id=?", params[:id], current_user)
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    ##################### CHECK THIS ###############
    params.require(:company).permit(:name, :link)
    ##################### CHECK THIS ###############
  end

end

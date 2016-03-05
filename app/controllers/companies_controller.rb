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

  before_action :find_company, only: [:update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  ### Companies are created, updated, and destroyed here. ###

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    respond_to do |format|
      if @company.save
        format.js { render :company_create_success }
      else
        format.js { render :company_create_failure}
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.js { render :company_update_success }
      else
        format.js { render :company_update_failure}
      end
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.js { render :company_destroy }
    end
  end

  private
    def find_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :link)
    end

    def authorize_user
      unless can? :manage, @company
        redirect_to root_path , alert: "Access Denied"
      end
    end

  end

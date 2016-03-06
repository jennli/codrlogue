# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CategoriesController < ApplicationController
  # User authetication
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def new
    @categorie = Category.new
  end

  def create
    @categorie = Category.new categorie_params
    @categorie.user = current_user
    respond_to do |format|
      if @categorie.save
        format.json { render json: @categorie.to_json }
      else
        format.json { render json: @categorie.errors }
      end
    end
  end

  def index
    @categories = current_user.categories
  end

  def show
    respond_to do |format|
      format.json { render json: @categorie.to_json }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @categorie.update categorie_params
        format.json { render json: @categorie.to_json }
      else
        format.json { render json: @categorie.errors }
      end
    end
  end

  def destory
    @categorie.user = current_user
    @categorie.destroy
  end

  private

  def set_category
    @category = Category.find params[:id]
  end

end

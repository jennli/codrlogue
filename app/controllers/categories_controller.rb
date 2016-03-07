# == Schema Information
#
# Table name: categorys
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
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.user = current_user
    respond_to do |format|
      if @category.save
        format.json { render json: @category.to_json }
      else
        format.json { render json: @category.errors }
      end
    end
  end

  def index
    @categories = current_user.categorys
  end

  def show
    respond_to do |format|
      format.json { render json: @category.to_json }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update category_params
        format.json { render json: @category.to_json }
      else
        format.json { render json: @category.errors }
      end
    end
  end

  def destroy
    @category.user = current_user
    @category.destroy
  end

  private

  def set_category
    @category = Category.find params[:id]
  end

end

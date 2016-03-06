# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  title       :string
#  rating      :integer
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SkillsController < ApplicationController
  before_action :find_skill, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    @skill.user = current_user
    respond_to do |format|
      if @skill.save
        format.js { render :skill_create_success }
      else
        format.js { render :skill_create_failure }
      end
    end
  end

  def index
    @skills = current_user.skills
  end

  def show
    respond_to do |format|
      format.json { render json: @skill.to_json }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @skill.update skill_params
        format.json { render json: @skill.to_json }
      else
        format.json { render json: @skill.errors }
      end
    end
  end

  def destory
    @skill.user = current_user
    @skill.destroy
    respond_to do |format|
      format.json { render :skill_destroy }
    end
  end

  private

  def find_skill
    @skill = Skill.find params[:id]
  end

  def skill_params
    params.require(:skill).permit(:title, :rating, :category_id)
  end

  def authorize_user
    unless can? :manage, @skill
      redirect_to root_path , alert: "Access Denied"
    end
  end
end

# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  project_link :string
#  github_link  :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.js { render :project_create_success }
      else
        format.js { render :project_create_failure }
      end
    end
  end

  def index
    @projects = current_user.projects
  end

  def show
    respond_to do |format|
      format.json { render json: @project.to_json }
    end
  end

  def edit
    respond_to do |format|
      format.js { render :project_edit }
    end
  end

  def update
    respond_to do |format|
      if @project.update project_params
        format.js { render :project_update_success }
      else
        format.js { render :project_update_failure }
      end
    end
  end

  def destroy
    @project.user = current_user
    @project.destroy
    respond_to do |format|
      format.js { render :project_destroy }
    end
  end

  private

  def find_project
    @project = Project.find params[:id]
  end

  def project_params
    params[:project][:project_link] = sanitize_url(params[:project][:project_link])
    params[:project][:github_link] = sanitize_url(params[:project][:github_link])
    params.require(:project).permit(:title,:description,:project_link,:github_link)
  end

  def authorize_user
    unless can? :manage, @project
      redirect_to root_path , alert: "Access Denied"
    end
  end
end

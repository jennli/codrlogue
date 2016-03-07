class UsersShortlistsController < ApplicationController
  before_action { @user = User.find params[:id] }
  def create
    session[:shortlist_ids] ||= []
    if session[:shortlist_ids].include? params[:id]
      respond_to do |wants|
        wants.js { render :add_exist }
      end
    else
      session[:shortlist_ids] << params[:id]
      respond_to do |wants|
        wants.js { render :add_successful }
      end
    end
  end
  def index
    if !session[:shortlist_ids] || session[:shortlist_ids].empty?
      redirect_to users_path, alert: "Shortlist is empty!"
    else
      @users = User.where(id: session[:shortlist_ids]).page(params[:page])
      render 'users/index'
    end
  end
  def destroy
    session[:shortlist_ids].delete(params[:id])
    render
  end
end

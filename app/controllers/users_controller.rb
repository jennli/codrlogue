# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  summary         :text
#  description     :text
#  admin           :boolean
#  is_available    :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UsersController < ApplicationController
  before_action :find_user, except: [:create, :index, :new]

  def index
    @users =  User.where('approved = true').order('created_at DESC').page(params[:page])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      login(@user)
      redirect_to root_path, notice: "Thanks for registering. You will be notified when your account is approved"
    else
      flash[:alert] = "Error creating user. see error below"
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    @user.slug = nil
    if @user.update user_params
      redirect_to @user, notice: "update successfully"
    else
      render :edit
    end
  end

  def edit_password
  end

  def update_password
    if @user.authenticate(params[:user][:old_password]) && (@user.update user_params)
      redirect_to @user, notice: "password update successfully"
    else
      flash[:alert]="Invalid. Please try again."
      render :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :summary, :description, :is_available)
  end

  def find_user
    @user = User.friendly.find params[:id]
  end

end

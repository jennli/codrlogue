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
  before_action :authenticate_user, only: [:edit, :edit_password]

  def index
    if params[:filter_string]
      if current_user.admin
        @users = User.where('admin = true').order(created_at: :asc).page(params[:page])
        render :admin
      else
        redirect_to root_path, alert:'access denied'
      end
    elsif params[:admin_random_string]
      if current_user.admin
        @users = User.order('approved nulls first').order(created_at: :asc).page(params[:page])
        render :admin
      else
        redirect_to root_path, alert:'access denied'
      end
    else
      @users =  User.where('approved = true').order('created_at DESC').page(params[:page])
    end
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
    if can? :view, @user
      new_instances
      render :show
    else
      redirect_to root_path, alert:" Access denied"
    end
  end

  def edit
  end

  def update
    @user.slug = nil
    if @user.update user_params
      if user_params.has_key?(:approved) || user_params.has_key?(:admin)
        flash[:notice] = "Update success from Administrator"
        @users = User.all.order('created_at DESC').page(params[:page])
        redirect_to admin_path(get_admin_random_string)
      else
        redirect_to @user, notice: "update successfully"
      end
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

  def contact

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :summary, :description, :is_available, :approved, :admin, :linkedin, :github, :twitter,:image,:attachment)
  end

  def find_user
    @user = User.friendly.find params[:id]
  end

  def authenticate_user
    if !can? :manage, @user
      redirect_to root_path, alert: "Access denied"
    end
  end
  def new_instances
    @skill = Skill.new
    @employment = Employment.new
  end

end

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
      filter_string = params[:filter_string]
      case filter_string
      when User::AVAILABLE
        @users = User.where(is_available: true, approved: true).page(params[:page])
      when User::UN_AVAILALBE
        @users = User.where(is_available: [false, nil], approved: true).page(params[:page])
      end
    end

    # if params[:search]
    #   keyword = params[:search]
    #   @users = []
    #   a = User.where("first_name ilike ? OR last_name ilike ? OR summary ilike ? OR description ilike ? ", "%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%")
    #   b = User.joins(:skills).where("title ilike ? ", "%#{keyword}%")
    #   c = User.joins(:employments).where("company_name ilike ?", "%#{keyword}%")
    #   d = User.joins(:projects).where("title ilike ? OR project.description ilike ?","%#{keyword}%","%#{keyword}%")
    #   @users = (a + b + c + d).uniq
    # end
    #
    #     if filter_string = User::Admin
    #     @users = User.where('admin = true').order(created_at: :asc).page(params[:page])
    #     render :admin
    #   elsif filter_string
    #
    #   else
    #     redirect_to root_path, alert:'access denied'
    #   end
    if params[:admin_random_string]
      if current_user.admin
        if params[:admin]
          @users = User.where('admin = true').order(created_at: :asc).page(params[:page])
        else
          @users = User.order('approved nulls first').order(created_at: :asc).page(params[:page])
        end
        render :admin
      else
        redirect_to root_path, alert:'access denied'
      end

    else
      @users =  User.where(approved: true).order('created_at DESC').page(params[:page])
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
    if params[:user][:remove_image]
      @user.remove_image!
      @user.save
    end
    if @user.update user_params
      if user_params.has_key?(:approved) || user_params.has_key?(:admin)
        flash[:notice] = "Status changed to #{user_params[:approved]} for #{@user.full_name} by dministrator"
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
    params[:user][:linkedin] = sanitize_url(params[:user][:linkedin])
    params[:user][:github] = sanitize_url(params[:user][:github])
    params[:user][:twitter] = sanitize_url(params[:user][:twitter])
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email, 
      :password, 
      :password_confirmation, 
      :summary, 
      :description, 
      :is_available, 
      :approved, 
      :admin, 
      :linkedin, 
      :github, 
      :twitter,
      :image,
      :attachment)
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
    @project = Project.new
    @skill = Skill.new
    @education = Education.new
    @employment = Employment.new
  end

end

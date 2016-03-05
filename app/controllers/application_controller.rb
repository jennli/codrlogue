class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end

  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find session[:user_id] if user_signed_in?
  end

  helper_method :current_user

  def login(user)
    session[:user_id] = user.id
  end

  def check_if_user_signed_in
    if !user_signed_in?
      redirect_to new_session_path
    end
  end

  def has_unread_messages?
    current_user.mailbox.inbox(unread: true).length > 0
  end

  helper_method :has_unread_messages?

  def get_admin_random_string
    (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  end

  helper_method :get_admin_random_string

  #   rescue_from ActiveRecord::RecordNotFound do
  #   flash[:warning] = 'Resource not found.'
  #   redirect_back_or root_path
  # end
  #
  # def redirect_back_or(path)
  #   redirect_to request.referer || path
  # end

end

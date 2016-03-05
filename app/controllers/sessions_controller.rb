class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email params[:email]

    if user && user.authenticate(params[:password])
      login(user)
      redirect_to root_path, notice: "Signed in"
    else
      flash[:alert] = "Invalid credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end

end

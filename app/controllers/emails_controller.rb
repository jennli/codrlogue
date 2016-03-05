class EmailsController < ApplicationController

  def show
    
  end

  def send_email
    @user = User.friendly.find(params[:id])
    employer_params = params.permit(:email, :body)
    ContactsMailer.notify_user(employer_params, @user).deliver_now
    redirect_to user_path(@user), notice: "An email has been sent!"
  end

end

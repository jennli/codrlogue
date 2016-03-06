class EmailsController < ApplicationController

  def show
    find_user
  end

  def send_email
    find_user
    employer_params = params.permit(:email, :body)
    @email = employer_params[:email]
    @message = employer_params[:body]

    if valid_email?(@email, @message)
      ContactsMailer.notify_user(employer_params, @user).deliver_later
      redirect_to user_path(@user), notice: "An email has been sent!"
    else
      flash[:alert] = "Please input a valid email and message"
      render :show
    end
  end


  private

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def valid_email?(email, message)
    valid_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    email.present? && (email =~ valid_regex) && message.present?
  end



end

class ContactsMailer < ApplicationMailer

  def notify_user(user)
    @user = user
    # Get the params from stuff
    #@employer = params.require(:user).permit(:email, :body)
    mail(to: @user.email, subject: "An employer wants to get in touch with you")
  end

end





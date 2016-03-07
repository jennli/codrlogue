class ContactsMailer < ApplicationMailer

  def notify_user(employer_info, user)
    @user = user
    @employer_info = employer_info
    mail(to: @user.email, subject: "An employer wants to get in touch with you!")
  end

end

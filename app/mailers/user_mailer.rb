class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'
 
  def password_reset_email(user, link)
    @user = user
    @link  = link
    mail(to: @user.email, subject: 'Reset your password :) ')
  end
end

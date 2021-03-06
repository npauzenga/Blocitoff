class UserMailer < ActionMailer::Base
  default from: "test@test.com"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.name} <#{user.email}>", subject: "Confirmation")
  end

  def password_reset(user)
    @user = user
    mail(to: "#{user.name} <#{user.email}>", subject: "Password reset")
  end
end

class UserMailer < ActionMailer::Base
  default from: "test@test.com"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.name} <#{user.email}>", subject: "Confirmation")
  end
end

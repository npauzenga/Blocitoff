class SendPasswordResetEmail
  include Interactor

  def call
    context.user.send_password_reset_email
  end
end

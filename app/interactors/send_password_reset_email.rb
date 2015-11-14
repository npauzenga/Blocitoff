class SendPasswordResetEmail
  include Interactor

  def call
    UserMailer.password_reset(context.user).deliver_now
  end
end

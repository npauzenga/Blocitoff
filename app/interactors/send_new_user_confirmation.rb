class SendNewUserConfirmation
  include Interactor

  def call
    UserMailer.registration_confirmation(context.user).deliver_now
  end
end

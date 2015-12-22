class FindPasswordResetUser
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    context.fail!(error_msg: "Email address not found") unless context.user
  end
end

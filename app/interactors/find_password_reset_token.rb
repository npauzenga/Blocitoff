class FindPasswordResetToken
  include Interactor

  def call
    redirect_to root_url if context.user.nil?
    hashed_token = User.digest(context.id, context.user.reset_token_salt)
    redirect_to root_url if hashed_token != context.user.reset_digest
  end
end

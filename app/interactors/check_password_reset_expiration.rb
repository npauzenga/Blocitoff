class CheckPasswordResetExpiration
  include Interactor

  def call
    return unless reset_token_expired?
    flash[:danger] = "Password reset has expired"
    redirect_to new_password_reset_url
  end

  private

  def reset_token_expired?
    context.user.reset_sent_at > 2.hours.ago
  end
end

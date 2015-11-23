class CheckPasswordResetExpiration
  include Interactor

  def call
    return unless reset_token_expired?
    context.fail!(errors: context.user.errors)
    redirect_to new_password_reset_url
  end

  private

  def reset_token_expired?
    context.user.reset_sent_at > 2.hours.ago
  end
end

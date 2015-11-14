class FindPasswordResetToken
  include Interactor

  def call
    if user_nil? || password_reset_expired? || id_digest != context.user.reset_digest
      context.fail!(errors: context.user.errors)
    end
  end

  def user_nil?
    context.user.nil?
  end

  def password_reset_expired?
    context.user.reset_sent_at > 2.hours.ago
  end

  def id_digest
    Encryptor.digest_token(context.id)
  end
end

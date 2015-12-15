class FindPasswordResetToken
  include Interactor

  def call
    context.fail! unless user_valid? && correct_token?
  end

  private

  def user_valid?
    !context.user.nil?
  end

  def correct_token?
    Encryptor.tokens_match?(context.id, context.user.reset_digest)
  end
end

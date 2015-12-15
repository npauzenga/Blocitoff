class FindPasswordResetToken
  include Interactor

  def call
    context.fail! if user_nil? || incorrect_token?
  end

  private

  def user_nil?
    context.user.nil?
  end

  def incorrect_token?
    Encryptor.digest_token(context.id) != context.user.reset_digest
  end
end

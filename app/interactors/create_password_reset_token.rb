class CreatePasswordResetToken
  include Interactor

  def call
    context.fail! unless context.user
    context.user.reset_token = generate_reset_token
    update_reset_attributes(context.enc, Time.zone.now)
  end

  private

  def generate_reset_token
    context.enc, context.raw = Encryptor.generate_token
    context.raw
  end

  def update_reset_attributes(digest, time)
    context.user.update_attribute(:reset_digest, digest)
    context.user.update_attribute(:reset_sent_at, time)
  end
end

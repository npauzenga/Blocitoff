class CreatePasswordResetToken
  include Interactor

  def call
    context.enc, context.raw = Encryptor.generate_token
    context.user.reset_token = context.raw
    update_reset_attributes(context.enc, Time.zone.now)
  end

  def update_reset_attributes(digest, time)
    context.user.update_attribute(:reset_digest, digest)
    context.user.update_attribute(:reset_sent_at, time)
  end
end

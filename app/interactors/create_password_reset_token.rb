class CreatePasswordResetToken
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  private

  def validate_input
    context.fail! if context.user.nil?
  end

  def execute
    context.user.reset_token = generate_reset_token
    update_reset_attributes(context.enc, Time.zone.now)
  end

  def validate_output
    context.fail! unless context.user.reset_token && correct_reset_digest
  end

  def generate_reset_token
    context.enc, context.raw = Encryptor.generate_token
    context.raw
  end

  def update_reset_attributes(digest, time)
    context.user.update_attribute(:reset_digest, digest)
    context.user.update_attribute(:reset_sent_at, time)
  end

  def correct_reset_digest
    context.user.reset_digest == context.enc
  end
end

class CreateConfirmationToken
  include Interactor

  def call
    context.enc, context.raw = Encryptor.generate_token
    context.user.confirm_token = context.raw
    context.user.update_attribute(:confirm_digest, context.enc)
  end
end

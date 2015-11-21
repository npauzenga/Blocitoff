class CreateConfirmationToken
  include Interactor

  def call
    context.enc, context.raw = Encryptor.generate_token
    context.user.confirm_token = context.raw
    update_confirm_digest
  end

  private

  def update_confirm_digest
    context.user.update_attribute(:confirm_digest, context.enc)
  end
end

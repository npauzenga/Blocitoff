class CreateConfirmationToken
  include Interactor

  def call
    context.fail!(error: "could not set token") unless context.user
    context.enc, context.raw = Encryptor.generate_token
    update_confirm_token
    update_confirm_digest
  end

  private

  def update_confirm_token
    context.user.confirm_token = context.raw
  end

  def update_confirm_digest
    context.user.update_attribute(:confirm_digest, context.enc)
  end
end

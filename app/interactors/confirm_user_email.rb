class ConfirmUserEmail
  include Interactor

  def call
    context.user = User.find_by(confirm_digest: Encryptor.digest_token(context.id))
    context.fail! unless context.user
    email_activate(context.user)
  end

  private

  def email_activate(user)
    user.update_attribute(:email_confirmed, true)
    user.update_attribute(:confirm_digest, nil)
    user.confirm_token = nil
    user.save!(validate: false)
  end
end

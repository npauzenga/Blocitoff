class CreateConfirmationToken
  include Interactor

  def call
    context.user.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end

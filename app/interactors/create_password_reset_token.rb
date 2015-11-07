class CreatePasswordResetToken
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    context.fail!(error_msg: "Email address not found") unless context.user

    # enc, raw = Encryptor.generate_token
    #
    # context.raw = SecureRandom.urlsafe_base64.to_s
    #  enc = OpenSSL::HMAC.hexdigest("SHA512",
    #                                Rails.application.secrets.secret_key_base,
    #                                context.raw).to_s

    context.user.create_reset_digest
  end
end

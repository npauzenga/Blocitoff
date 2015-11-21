class AuthenticateUser
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    authenticate_user(context.user, context.password)
  end

  private

  def authenticate_user(user, password)
    return if user && password_valid?(password) && context.user.email_confirmed
    context.fail!(errors: "invalid Email or Password")
  end

  def password_valid?(password)
    Encryptor.passwords_match?(password,
                               context.user.password_salt,
                               context.user.password_hash)
  end
end

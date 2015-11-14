class AuthenticateUser
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    authenticate_user(context.user, context.password)
  end

  def authenticate_user(user, password)
    return if user && Encryptor.passwords_match?(password, user.password_salt, user.password_hash)
    context.fail!(errors: user.errors)
  end
end

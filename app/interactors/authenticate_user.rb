class AuthenticateUser
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    authenticate_user(context.user, context.password)
  end

  def authenticate_user(user, password)
    return if user && password_vaild? && user.email_confirmed
    context.fail!(errors: "invalid Email or Password")
  end

  def password_valid?
    Encryptor.passwords_match?(password, user.password_salt, user.password_hash)
  end
end

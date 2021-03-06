class EncryptPassword
  include Interactor

  def call
    context.fail!(errors: context.user.errors) unless password_present?
    update_password_attributes(context.user.password)
  end

  private

  def password_present?
    context.user.password.present?
  end

  def update_password_attributes(password)
    password_salt = Encryptor.generate_salt
    password_hash = Encryptor.digest_password(password, password_salt)
    context.user.update_attributes(password_salt: password_salt,
                                   password_hash: password_hash)
  end
end

class UpdatePassword
  include Interactor

  def call
    context.fail!(errors: context.user.errors) unless password_update
    hashed_password_update(context.user, context.user.password)
    reset_digest_update
  end

  private

  def reset_digest_update
    context.user.update_attribute(:reset_digest, nil)
  end

  def password_update
    context.user.update(context.user_params)
  end

  def hashed_password_update(user, password)
    salt = Encryptor.generate_salt
    password_hash = Encryptor.digest_password(password, salt)
    user.update_attribute(:password_salt, salt)
    user.update_attribute(:password_hash, password_hash)
  end
end

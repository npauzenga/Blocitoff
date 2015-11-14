class UpdatePassword
  include Interactor

  def call
    context.fail!(errors: context.user.errors) unless password_update
  end

  private

  def password_update
    context.user.update_attributes(context.user_params)
    context.user.update_attribute(:reset_digest, nil)
    update_hashed_password(context.user, context.user.password)
  end

  def update_hashed_password(user, password)
    salt = Encryptor.generate_salt
    password_hash = Encryptor.digest_password(password, salt)
    user.update_attribute(:password_salt, salt)
    user.update_attribute(:password_hash, password_hash)
  end
end

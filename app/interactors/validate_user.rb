class ValidateUser
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    authenticate_user(context.user, context.password)
  end
  
  def authenticate_user(user, password)
    return if user && user.authenticate(password)
    context.fail!(errors: user.errors)
  end
end

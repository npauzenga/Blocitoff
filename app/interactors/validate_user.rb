class ValidateUser
  include Interactor

  def call
    context.user = User.find_by(email: context.email.downcase)
    user = context.user
    password = context.password
    errors = context.user.errors
    context.fail!(errors: errors) unless user && user.authenticate(password)
  end
end

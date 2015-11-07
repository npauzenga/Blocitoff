class UpdatePassword
  include Interactor

  def call
    errors = context.user.errors
    user = context.user
    user_params = context.user_params
    context.fail!(errors: errors) unless user.update_attributes(user_params)
  end
end

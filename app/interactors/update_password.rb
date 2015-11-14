class UpdatePassword
  include Interactor

  def call
    context.fail!(errors: context.user.errors) unless password_update
  end

  def password_update
    context.user.update_attributes(context.user_params)
  end
end

class UpdatePassword
  include Interactor

  def call
    # reimpliments password_reset_expired?
    context.fail!(errors: "msg") if context.user.reset_sent_at < 2.hours.ago
    errors = context.user.errors
    user = context.user
    user_params = context.user_params
    context.fail!(errors: errors) unless user.update_attributes(user_params)
  end
end

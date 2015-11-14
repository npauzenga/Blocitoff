class ConfirmUserEmail
  include Interactor

  def call
    context.user = User.find_by_confirm_token(context.id)
    context.fail! unless context.user
    context.user.email_activate
  end

  private

  def email_activate
    context.user.email_confirmed = true
    context.user.confirm_token = nil
    save!(validate: false)
  end
end

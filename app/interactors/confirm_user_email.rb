class ConfirmUserEmail
  include Interactor

  def call
    context.user = User.find_by_confirm_token(context.id)
    context.fail! unless context.user
  end
end

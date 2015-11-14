class LogOutUser
  include Interactor

  def call
    context.session.delete(:user_id)
    @current_user = nil
  end
end

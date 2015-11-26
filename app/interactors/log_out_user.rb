class LogOutUser
  include Interactor

  def call
    context.session[:user_id] = nil
    @current_user = nil
  end
end

class LoginUser
  include Interactor

  def call
    context.fail!(error: "login failed") unless context.user && context.session
    context.session[:user_id] = context.user.id
  end
end

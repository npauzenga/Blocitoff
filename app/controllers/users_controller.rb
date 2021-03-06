class UsersController < AuthenticatedController
  skip_before_action :log_in_required, only: %i(new create)

  def new
    @user = User.new
  end

  def create
    result = CreateUser.call(user_params: user_params)

    if result.success?
      flash[:notice] = "Thanks! Please check your email to complete sign up"
      redirect_to sign_in_path
    else
      flash[:error] = "Uh oh. Something went wrong."
      redirect_to sign_up_path
    end
  end

  def show
    @user = ShowUser.call(id: params[:id], current_id: session[:user_id]).user
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end

class PasswordResetsController < ApplicationController
  before_action :verify_password_reset_user, only: %i(edit update)

  def new
  end

  def edit
  end

  def create
    request = RequestPasswordResetToken.call(email: password_params)

    if request.success?
      flash[:notice] = "Email sent with reset instructions"
      redirect_to root_url
    else
      flash.now[:error] = "Email address not found"
      render "new"
    end
  end

  def update
    password_reset = ResetPassword.call(user_params: user_params, user: @user,
                                session: session)

    if password_reset.success?
      flash[:success] = "Password has been reset"
      redirect_to password_reset.user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def password_params
    params.require(:password_reset).require(:email)
  end

  def verify_password_reset_user
    @user = VerifyPasswordResetUser.call(
      user: User.find_by(email: params[:email]),
      id: params[:id]).user
  end
end

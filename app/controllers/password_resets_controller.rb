class PasswordResetsController < ApplicationController
  before_action      :find_user,        only: %i(edit update)
  before_action      :check_expiration, only: %i(edit update)

  def new
  end

  def edit
  end

  def create
    result = RequestPasswordResetToken.call(email: password_params)

    if result.success?
      flash[:notice] = "Email sent with reset instructions"
      redirect_to root_url
    else
      flash.now[:error] = "Email address not found"
      render "new"
    end
  end

  def update
    result = ResetPassword.call(user_params: user_params, user: @user,
                                session: session)

    if update_password.success?
      flash[:success] = "Password has been reset"
      redirect_to update_password.user
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

  # move these to interactors via an organizer
  def find_user
    @user = User.find_by(email: params[:email])
    redirect_to root_url if @user.nil?
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = "Password reset has expired"
    redirect_to new_password_reset_url
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Thanks! Please check your email to complete sign up"
      redirect_to sign_in_path
    else
      flash[:error] = "Uh oh. Something went wrong."
      render "new"
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to Blocitoff!"
    else
      flash[:error] = "Sorry, user does not exist"
      redirect_to root
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

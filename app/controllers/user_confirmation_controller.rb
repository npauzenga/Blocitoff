class UserConfirmationController < ApplicationController
  def show
  end

  def update
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to Blocitoff!"
    else
      flash[:error] = "Sorry, user does not exist"
      redirect_to root_url
    end
  end
end

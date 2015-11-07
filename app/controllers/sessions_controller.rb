class SessionsController < ApplicationController
  def new
  end

  def create
    valid_user = ValidateUser.call(email:    params[:session][:email],
                                   password: params[:session][:password])

    if valid_user.success?
      log_in valid_user.user
      redirect_to valid_user.user
    else
      flash.now[:error] = "There was a problem signing in"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    authenticated = AuthenticateUser.call(email:    params[:sign_in][:email],
                                          password: params[:sign_in][:password])

    if authenticated.success?
      log_in(authenticated.user)
      redirect_to authenticated.user
      flash[:notice] = "Welcome back #{authenticated.user.name}"
    else
      flash[:error] = "There was a problem signing in"
      render :new
    end
  end

  def destroy
    result = LogOutUser.call(session: session)
    if result.success?
      redirect_to sign_in_path
      flash[:notice] = "You have been logged out"
    else
      redirect_to current_user
      flash[:error] = "We couldn't log you out."
    end
  end
end

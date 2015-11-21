class SessionsController < ApplicationController
  def new
  end

  def create
    user_session = CreateUserSession.call(email:    params[:session][:email],
                                          password: params[:session][:password],
                                          session:  session)

    if user_session.success?
      redirect_to user_session.user
    else
      flash[:error] = "There was a problem signing in"
      render "new"
    end
  end

  def destroy
    result = LogOutUser.call(session: session)
    if result.success?
      redirect_to root_url
    else
      flash[:error] = "We couldn't log you out."
    end
  end
end

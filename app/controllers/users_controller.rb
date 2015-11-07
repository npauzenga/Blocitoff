class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = CreateUser.call(user_params: user_params)

    if result.success?
      UserMailer.registration_confirmation(result.user).deliver_now
      flash[:notice] = "Thanks! Please check your email to complete sign up"
      redirect_to sign_in_path
    else
      flash[:error] = "Uh oh. Something went wrong."
      render "new"
    end
  end

  def show
    result = ShowUser.call(id: params[:id])
    @user = result.user
    @todos = result.todos
    @todo = result.todo
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end

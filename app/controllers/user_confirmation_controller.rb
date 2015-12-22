class UserConfirmationController < ApplicationController
  def show
    confirmed = ConfirmUserEmail.call(id: params[:id])

    if confirmed.success?
      flash[:success] = "Welcome to Blocitoff!"
    else
      flash[:error] = "Sorry, user does not exist"
      redirect_to root_url
    end
  end
end

class WelcomeController < ApplicationController
  include SessionsHelper

  def index
    return unless logged_in?
    redirect_to user_path(current_user)
  end
end

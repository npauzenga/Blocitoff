class WelcomeController < AuthenticatedController

  def index
    redirect_to user_path(current_user)
  end
end

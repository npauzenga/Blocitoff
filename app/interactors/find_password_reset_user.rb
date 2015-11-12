class FindPasswordResetUser
  include Interactor

  def call
    redirect_to root_url if context.user.nil?
  end
end

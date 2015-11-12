class CheckPasswordResetExpiration
  include Interactor

  def call
    return unless context.user.password_reset_expired?
    flash[:danger] = "Password reset has expired"
    redirect_to new_password_reset_url
  end
end

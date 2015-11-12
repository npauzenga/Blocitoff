class VerifyPasswordResetUser
  include Interactor::Organizer

  organize FindPasswordResetToken, CheckPasswordResetExpiration
end

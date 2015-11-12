class VerifyPasswordResetUser
  include Interactor::Organizer

  organize FindPasswordResetUser, CheckPasswordResetExpiration
end

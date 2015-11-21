class RequestPasswordResetToken
  include Interactor::Organizer

  organize FindPasswordResetUser,
           CreatePasswordResetToken,
           SendPasswordResetEmail
end

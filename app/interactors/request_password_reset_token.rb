class RequestPasswordResetToken
  include Interactor::Organizer

  organize CreatePasswordResetToken, SendPasswordResetEmail
end

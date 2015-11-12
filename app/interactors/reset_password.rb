class ResetPassword
  include Interactor::Organizer

  organize UpdatePassword, LoginUser
end

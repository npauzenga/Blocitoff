class CreateUserSession
  include Interactor::Organizer

  organize AuthenticateUser, LoginUser
end

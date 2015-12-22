class CreateUser
  include Interactor::Organizer

  organize MakeNewUser,
           EncryptPassword,
           SaveUser,
           CreateConfirmationToken,
           SendNewUserConfirmation
end

class CreateUser
  include Interactor

  def call
    context.user = User.new(context.user_params)
    context.fail!(errors: context.user.errors) unless context.user.save
    UserMailer.registration_confirmation(context.user).deliver_now
  end
end

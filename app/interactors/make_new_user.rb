class MakeNewUser
  include Interactor

  def call
    context.user = User.new(context.user_params)
  end
end

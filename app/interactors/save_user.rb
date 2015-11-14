class SaveUser
  include Interactor

  def call
    context.fail!(errors: context.user.errors) unless context.user.save
  end
end

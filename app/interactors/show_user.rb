class ShowUser
  include Interactor

  def call
    context.user = User.find(context.id)
    rescue ActiveRecord::RecordNotFound
      context.user = User.find(context.current_id)
  end
end

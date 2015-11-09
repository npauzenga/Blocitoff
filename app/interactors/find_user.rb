class FindUser
  include Interactor

  def call
    begin
      context.user = User.find(context.id)
    rescue ActiveRecord::RecordNotFound
      context.user = User.find(context.current_id)
    end
  end
end

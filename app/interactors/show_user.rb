class ShowUser
  include Interactor

  def call
    context.user = User.find(context.id)
    context.todos = context.user.todos
    context.todo = Todo.new
  end
end

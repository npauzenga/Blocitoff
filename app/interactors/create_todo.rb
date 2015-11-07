class CreateTodo
  include Interactor

  def call
    context.user = User.find(context.user_id)
    todo = context.user.todos.new(context.todo_param)

    context.fail!(errors: todo.errors) unless todo.save
  end
end

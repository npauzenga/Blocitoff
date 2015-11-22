class CreateTodo
  include Interactor

  def call
    todo = context.user.todos.new(context.todo_params)
    context.fail!(errors: todo.errors) unless todo.save
  end
end

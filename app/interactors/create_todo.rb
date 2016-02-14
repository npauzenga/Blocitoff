class CreateTodo
  include Interactor

  def call
    context.todo = context.user.todos.new(context.todo_params)
    context.fail!(errors: context.todo.errors) unless context.todo.save
  end
end

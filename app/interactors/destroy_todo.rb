class DestroyTodo
  include Interactor

  def call
    context.todo = Todo.find(context.todo_id)
    context.user = context.todo.user

    context.fail!(errors: todo.errors) unless context.todo.destroy
  end
end

class DestroyTodo
  include Interactor

  def call
    find_todo
    find_user
    context.fail!(errors: todo.errors) unless context.todo.destroy
  end

  private

  def find_user
    context.user = context.todo.user
  end

  def find_todo
    context.todo = Todo.find(context.todo_id)
  end
end

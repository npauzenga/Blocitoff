class ShowTodo
  include Interactor

  def call
    context.todo = Todo.find(params[:id])
  end
end

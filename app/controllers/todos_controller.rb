class TodosController < AuthenticatedController
  def create
    result = CreateTodo.call(user:        current_user,
                             todo_params: todo_params)

    if result.success?
      redirect_to result.user
      flash[:notice] = "Your new TODO was saved"
    else
      redirect_to result.user
      flash[:error] = "Your TODO was not saved"
    end
  end

  def destroy
    destroyed = DestroyTodo.call(todo_id: params[:id])
    @todo = destroyed.todo
    if destroyed.success?
      flash[:notice] = "Todo completed!"
    else
      flash[:error] = "There was a problem"
    end

    response_type
  end

  private

  def response_type
    respond_to do |format|
      format.html { redirect_to @todo.user }
      format.js
    end
  end

  def todo_params
    params.require(:todo).permit(:description)
  end
end

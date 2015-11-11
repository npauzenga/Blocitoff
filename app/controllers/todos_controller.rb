class TodosController < AuthenticatedController
  def new
  end

  def create
    result = CreateTodo.call(user_id:     params[:user_id],
                             todo_params: todo_params)

    if result.success?
      redirect_to result.user, notice: "Your new TODO was saved"
    else
      flash[:error] = "Your TODO was not saved"
      redirect_to result.user
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def destroy
    result = DestroyTodo.call(todo_id: params[:id])

    if result.success?
      flash[:notice] = "Todo completed!"
    else
      flash[:error] = "There was a problem"
    end

    respond_to do |format|
      format.html { redirect_to result.user }
      format.js
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end
end

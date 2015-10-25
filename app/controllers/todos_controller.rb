class TodosController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(params[:user_id])
    @todo = @user.todos.new(todo_params)

    if @todo.save
      redirect_to @user, notice: "Your new TODO was saved"
    else
      flash[:error] = "Your TODO was not saved"
      redirect_to @user
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def destroy
    @todo = Todo.find(params[:id])

    if @todo.destroy
      flash[:notice] = "Todo completed!"
      redirect_to root_path
    else
      flash[:error] = "There was a problem"
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end
end

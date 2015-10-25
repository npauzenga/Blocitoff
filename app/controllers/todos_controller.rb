class TodosController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(params[:user_id])
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @user, notice: "Your new TODO was saved"
    else
      flash[:error] = "Your TODO was not saved"
      redirect_to @user
    end
  end

  def show
    @todo = Todo.find params[:id]
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end
end

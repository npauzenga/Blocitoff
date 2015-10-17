class TodosController < ApplicationController
  def new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Your new TODO was saved"
    else
      flash[:error] = "Your TODO was not saved"
      render :new
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

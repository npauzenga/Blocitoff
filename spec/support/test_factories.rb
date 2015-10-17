module TestFactories
  def valid_todo(options = {})
    todo_options = {
      description: "This is valid"
    }.merge(options)
    Todo.create(todo_options)
  end
end

require "spec_helper"
require "rake"

feature "Todos are automatically purged" do
  include TestFactories

  rake = Rake.application
  rake.init
  rake.load_rakefile

  let(:todo) { valid_todo }

  scenario "Successfully after 7 days" do
    old_todo = todo
    old_todo.update_attribute(:created_at, (Time.now.utc - 7.days))
    rake["todo:delete_items"].invoke
    expect(Todo.find_by(id: old_todo.id)).to be nil
  end
end

# require "rails_helper"
#
# feature "Todos are automatically purged" do
#   include TestFactories
#
#   let(:todo) { valid_todo }
#   # set whenever to work in test
#   scenario "Successfully after 7 days" do
#     old_todo = todo
#     old_todo.update_attribute(:created_at, (Time.now.utc - 7.days))
#     Time.now.change(hour: 0)
#     expect(Todo.find_by(id: old_todo.id)).to be nil
#   end
# end

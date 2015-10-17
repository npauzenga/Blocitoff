require "rails_helper"

RSpec.describe Todo, type: :model do
  include TestFactories
  describe "Validations" do
    let(:todo) { valid_todo }
    describe "description validation" do
      it "only allows a Todo to be saved with a description" do
        todo.description = nil
        expect(todo.save).to eq false
      end
    end
  end
end

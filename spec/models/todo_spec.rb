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

  describe "methods" do
    let(:todo) { valid_todo }

    describe "#days_left" do
      it "displays the days left until deletion" do
        todo.update_attribute(:created_at, (DateTime.now.utc - 1))
        expect(todo.days_left).to eq 6
      end
    end
  end
end

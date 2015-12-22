require "rails_helper"

RSpec.describe ShowUser do
  describe ".call" do
    let(:user)         { create(:confirmed_user) }
    let(:current_user) { create(:confirmed_user) }

    context "when successful" do
      subject do
        described_class.call(id: user.id, current_id: current_user.id)
      end

      it "assigns a user" do
        expect(subject.user).to eq(user)
      end
    end

    context "when provided user is invalid" do
      subject do
        described_class.call(id: nil, current_id: current_user.id)
      end

      it "assigns the current user as user" do
        expect(subject.user).to eq(current_user)
      end
    end
  end
end

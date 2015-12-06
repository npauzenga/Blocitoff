require "rails_helper"
include BCrypt

RSpec.describe Encryptor do
  context "methods" do
    let(:salt)     { Engine.generate_salt }
    let(:password) { "helloworld" }

    describe "self.digest_password" do
      it "encrypts a password" do
        expect(described_class.digest_password(password, salt)).to eq(Engine.hash_secret(password, salt))
      end

      it "returns a string" do
        expect(described_class.digest_password(password, salt)).to be_a(String)
      end
    end

    describe "self.generate_salt" do
      it "returns a string" do
        expect(described_class.generate_salt).to be_a(String)
      end

      it "is exactly 29 characters long" do
        salt = described_class.generate_salt
        expect(salt.length).to eq(29)
      end
    end

    describe "self.passwords_match?" do
      it "returns true if encrypted_password matches user-provided password" do
        subject do
          described_class.passwords_match?(password, salt, encrypted_password)
        end

        encrypted_password = described_class.digest_password(password, salt)
        is_expected.to be(true)
      end
    end
  end
end

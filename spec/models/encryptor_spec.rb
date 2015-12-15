require "rails_helper"
include BCrypt

RSpec.describe Encryptor do
  context "methods" do
    let(:salt)     { Engine.generate_salt }
    let(:password) { "helloworld" }

    describe "self.digest_password" do
      it "encrypts a password" do
        expect(described_class.digest_password(password, salt)).
          to eq(Engine.hash_secret(password, salt))
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
      subject do
        described_class.passwords_match?(
          password, salt, described_class.digest_password(password, salt)
        )
      end

      it "returns true if encrypted_password matches user-provided password" do
        is_expected.to be(true)
      end
    end

    describe "self.digest_token" do
      subject do
        described_class.digest_token("test")
      end

      it "returns a string" do
        is_expected.to be_a(String)
      end
    end

    describe "self.generate_token" do
      subject do
        described_class.generate_token
      end

      it "returns a raw and a hashed token" do
        is_expected.to be_an(Array)
      end

      it "sets the hashed token correctly" do
        enc, raw = described_class.generate_token
        expect(described_class.digest_token(raw)).to eq(enc)
      end
    end

    describe "self.tokens_match?" do
      context "when successful" do
        subject do
          enc, raw = described_class.generate_token
          described_class.tokens_match?(raw, enc)
        end

        it "returns true when the tokens match" do
          is_expected.to be_truthy
        end
      end

      context "when unsuccessful" do
        subject do
          raw = described_class.generate_token
          enc = "nope"
          described_class.tokens_match?(raw[0], enc)
        end

        it "returns false when the tokens don't match" do
          is_expected.to be_falsey
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Installation, type: :model do
  subject(:installation) { described_class.new(github_id: 7) }

  describe "access_token_expired?" do
    it "checks for a token, expiration, and expiration in the future" do
      expect(installation.access_token_expired?).to be(true)

      installation.access_token = "abc"
      expect(installation.access_token_expired?).to be(true)

      installation.access_token_expires_at = Time.now - 1
      expect(installation.access_token_expired?).to be(true)

      installation.access_token_expires_at = Time.now + 10
      expect(installation.access_token_expired?).to be(false)
    end
  end

  describe "client" do
    context "with a valid access token" do
      before do
        installation.access_token = "abc"
        installation.access_token_expires_at = Time.now + 30
      end

      it "memoizes and returns a client" do
        client = installation.client
        expect(client).to be_a(Octokit::Client)
        expect(installation.client).to eq(client)
      end
    end

    context "when an access token expires" do
      it "generates a new token and returns a new client" do
        installation.access_token = "abc"
        installation.access_token_expires_at = Time.now + 30
        expired_client = installation.client
        installation.access_token_expires_at = Time.now - 30

        expect(installation).to receive(:generate_new_access_token!)
        new_client = installation.client

        expect(new_client).to_not eq(expired_client)
      end
    end
  end

  describe "generate_new_access_token!" do
    it "gets a new token from github and saves said token" do
      expect(Github.app_client).to receive(:create_installation_access_token).with(7) do
        {token: "new token", expires_at: (Time.now+60).iso8601}
      end

      expect { installation.generate_new_access_token! }.to change { installation.access_token }
    end
  end
end

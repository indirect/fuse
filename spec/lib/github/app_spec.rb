require "rails_helper"

RSpec.describe Github::App do
  let(:key_path) { File.expand_path("../../support/app_key.pem", __dir__) }
  let(:app_config) { {id: "1234", name: "fuse", private_key: File.read(key_path)} }
  subject(:app) { Github::App.new(app_config) }

  it "has a #github_id" do
    expect(app.github_id).to eq(app_config[:id])
  end

  it "has a #private_key" do
    expect(app.private_key).to eq(File.read(key_path))
  end

  describe "#bearer_token" do
    it "returns a token" do
      time = Time.parse("2017-07-22T20:15:52-07:00")
      token = app.bearer_token(time)
      expect(token).to eq(
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE1MDA3Nzk3NTIsImV4cCI" \
        "6MTUwMDc4MDM1MiwiaXNzIjoiMTIzNCJ9.fs5STElirbT7xIiDqLWBIuknNvtO-WPtVq" \
        "D6lvAzT9YMlQBLG-5MObE0oh54QZoLfQtbz4qABdn6BkJqDkTWpQ"
      )
    end
  end
end
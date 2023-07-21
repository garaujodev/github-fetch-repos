require 'rails_helper'

RSpec.describe GitHub::User do
  describe "#call" do
    context "when the user exists on GitHub" do
      it "returns the user data" do
        username = "test_user"
        github_user_data = { login: "test_user", name: "Test User", public_repos: 10 }

        allow_any_instance_of(Octokit::Client).to receive(:user).with(username).and_return(github_user_data)

        service = GitHub::User.new(username)
        user_data = service.call

        expect(user_data).to eq(github_user_data)
      end
    end

    context "when the user does not exist on GitHub" do
      it "returns nil" do
        username = "non_existent_user"

        allow_any_instance_of(Octokit::Client).to receive(:user).with(username).and_raise(Octokit::NotFound)

        service = GitHub::User.new(username)
        user_data = service.call

        expect(user_data).to be_nil
      end
    end

    context "when an unexpected error occurs" do
      it "raises the error" do
        username = "test_user"

        allow_any_instance_of(Octokit::Client).to receive(:user).with(username).and_raise(StandardError)

        service = GitHub::User.new(username)

        expect { service.call }.to raise_error(StandardError)
      end
    end
  end
end

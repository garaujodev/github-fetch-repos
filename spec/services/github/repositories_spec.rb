# spec/services/github/repositories_spec.rb
require 'rails_helper'

RSpec.describe GitHub::Repositories do
  describe '#call' do
    context 'when the user exists on GitHub' do
      it 'returns a list of repositories for the given username' do
        username = 'test_user'
        github_repositories = [
          { 'name' => 'repo1', 'stargazers_count' => 10 },
          { 'name' => 'repo2', 'stargazers_count' => 20 }
        ]

        allow_any_instance_of(Octokit::Client).to receive(:repositories).with(username).and_return(github_repositories)

        service = GitHub::Repositories.new(username)
        repositories = service.call

        expect(repositories).to eq(github_repositories)
      end
    end

    context 'when the user does not exist on GitHub' do
      it 'returns an empty array' do
        username = 'non_existent_user'

        allow_any_instance_of(Octokit::Client).to receive(:repositories).with(username).and_raise(Octokit::NotFound)

        service = GitHub::Repositories.new(username)
        repositories = service.call

        expect(repositories).to eq([])
      end
    end

    context 'when an unexpected error occurs' do
      it 'raises the error' do
        username = 'test_user'

        allow_any_instance_of(Octokit::Client).to receive(:repositories).with(username).and_raise(StandardError)

        service = GitHub::Repositories.new(username)

        expect { service.call }.to raise_error(StandardError)
      end
    end
  end
end

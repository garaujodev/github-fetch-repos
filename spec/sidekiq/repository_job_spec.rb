require 'rails_helper'

RSpec.describe RepositoryJob, type: :job do
  describe '#perform' do
    let(:username) { 'test_user' }
    let(:repositories) do
      [
        { 'name' => 'repo1', 'stargazers_count' => 10 },
        { 'name' => 'repo2', 'stargazers_count' => 20 }
      ]
    end

    it 'fetches repositories and inserts into the database' do
      allow(GitHub::Repositories).to receive(:call).with(username).and_return(repositories)

      expect do
        RepositoryJob.new.perform(username)
      end.to change(Repository, :count).by(2)

      repository1 = Repository.find_by(name: 'repo1', owner: username)
      repository2 = Repository.find_by(name: 'repo2', owner: username)

      expect(repository1.stars).to eq(10)
      expect(repository2.stars).to eq(20)
    end
  end
end

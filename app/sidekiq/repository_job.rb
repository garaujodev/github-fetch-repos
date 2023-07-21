class RepositoryJob
  include Sidekiq::Job

  def perform(username)
    repositories = GitHub::Repositories.call(username)

    repo_list = repositories.map do |repo|
      { 'name' => repo['name'], 'owner' => username, 'stars' => repo['stargazers_count'] }
    end

    Repository.insert_all(repo_list)
  end
end

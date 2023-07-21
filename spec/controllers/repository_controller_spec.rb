require 'rails_helper'

RSpec.describe RepositoryController, type: :controller do
  describe 'POST #create' do
    it 'enqueues RepositoryJob with the provided username' do
      username = 'github'

      expect do
        post :create, params: { username: username }
      end.to change(RepositoryJob.jobs, :size).by(1)

      expect(RepositoryJob).to have_enqueued_sidekiq_job(username)
    end

    it 'returns a successful response' do
      post :create, params: { username: 'github' }
      expect(response).to have_http_status(:success)
    end

    it 'does not enqueue RepositoryJob and returns a not found response if user not exists' do
      expect do
        post :create, params: { username: 'this_username_doesnt_exist' }
      end.not_to change(RepositoryJob.jobs, :size)

      expect(response).to have_http_status(:not_found)
    end

    it 'does not enqueue RepositoryJob and returns a bad request response if username is not provided' do
      expect do
        post :create, params: {}
      end.not_to change(RepositoryJob.jobs, :size)

      expect(response).to have_http_status(:bad_request)
    end
  end
end

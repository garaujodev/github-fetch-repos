class RepositoryController < ApplicationController
  def create
    username = params[:username]

    if username.present?
      RepositoryJob.perform_async(username)
      head :no_content # Retorna o status code 204 (No Content) se a execução ocorrer normalmente
    else
      head :bad_request # Retorna o status code 400 (Bad Request) se o parâmetro "username" não estiver presente
    end
  end
end


class RepositoryController < ApplicationController
  def create
    username = params[:username]

    if username.present?
      if GitHub::User.call(username)
        RepositoryJob.perform_async(username)

        head :no_content # Retorna o status code 204 (No Content) se a execução ocorrer normalmente
      else
        head :not_found # Retorna o status code 404 (Not Found) se o usuario não existir no GitHub
      end
    else
      head :bad_request # Retorna o status code 400 (Bad Request) se o parâmetro "username" não estiver presente
    end
  end
end

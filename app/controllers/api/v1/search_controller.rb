module Api::V1
  class SearchController < ApplicationController
    before_action :authorize_request

    # GET /repositories
    def repositories
      data, next_id = Search.repositories(@current_user.oauth_token, params["next_id"])
      render json: {data: data, pagination: {next_id: next_id}}, status: :ok
    end

    # GET /search_repositories
    def search_repositories
      if params["query"].nil? || params["query"] == ""
        render json: {data: "O campo 'query' é obrigatório!!!"}, status: :ok
        return
      end

      data, pagination = Search.search_repositories(@current_user.oauth_token, params)
      render json: {data: data, pagination: pagination}, status: :ok
    end
  end
end
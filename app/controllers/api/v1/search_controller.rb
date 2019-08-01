module Api::V1
  class SearchController < ApplicationController
    before_action :authorize_request

    # GET /
    def repositories
      render json: Search.repositories, status: :ok
    end
  end
end
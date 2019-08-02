module Api::V1
  class SearchController < ApplicationController
    before_action :authorize_request

    # pagination = {
    #     "next_page": data,
    #     "last_page": 12121212,
    #     "next_page_url": "http://localhost:3000/stories?page[number]=#{1 + 1}",
    #     "prev_page_url": "http://localhost:3000/stories?page[number]=#{1 - 1}"
    # }

    # GET /
    def repositories
      data, next_id = Search.repositories(@current_user.oauth_token, params["next_id"])
      render json: {data: data, pagination: {next_id: next_id}}, status: :ok
    end
  end
end
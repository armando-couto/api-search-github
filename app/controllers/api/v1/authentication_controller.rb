module Api::V1
  class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :auth

    # POST /auth
    def auth
      @user = User.find_by_name(params[:name])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), oauth_token: @user.oauth_token}, status: :ok
      else
        render json: {error: 'unauthorized'}, status: :unauthorized
      end
    end

    private

    def login_params
      params.permit(:name, :password)
    end
  end
end
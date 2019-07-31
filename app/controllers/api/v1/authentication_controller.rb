module Api::V1
  class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :auth

    # POST /auth
    def auth
      @usuario = Usuario.find_by_email(params[:email])
      if @usuario&.authenticate(params[:password])
        token = JsonWebToken.encode(usuario_id: @usuario.id)
        time = Time.now + 24.hours.to_i
        render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), name: @usuario.nome}, status: :ok
      else
        render json: {error: 'unauthorized'}, status: :unauthorized
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end
Rails.application.routes.draw do
  get '*other', to: 'static#index'
  get '*other', to: redirect('/')

  namespace 'api' do
    namespace 'v1' do
      post '/auth', to: 'authentication#auth'

    end
  end
end
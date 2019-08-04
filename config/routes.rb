Rails.application.routes.draw do
  get '/', to: 'static#index'

  namespace 'api' do
    namespace 'v1' do
      post '/auth', to: 'authentication#auth'

      get '/repositories', to: 'search#repositories'
      get '/search_repositories', to: 'search#search_repositories'
    end
  end
end
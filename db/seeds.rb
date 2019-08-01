puts "Populando o banco de dados"

User.create!({name: "armando", password: "123456", oauth_token: Rails.application.credentials.github[:token]})
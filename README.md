# API de Consulta a API do GitHub


### Build Readme

    cd build_readme/
    ruby md2html.rb ../README.md ../public/index.html

### API do GitHub (https://github.com/kristjanjansen/md2html)
    https://developer.github.com/v3/search/#search-repositories

### Demo
    https://api-search-github.herokuapp.com/

### Desafio

- Listagem de todos os repositórios públicos;
- Busca de repositórios possibilitando:
    - Termo de busca textual (texto livre a ser pesquisado);
    - Buscar por linguagem específica (valor padrão ‘​ruby’​);
    - Buscar por repositórios de um usuário;
    - Ordenar via quantidade de estrelas de um repositório;
    - Ordenar via quantidade de forks de um repositório;
    - Ordenar via data de atualização;
    - Permitir ordenação ascendente e descendente;
- Repositórios devem conter:
    - Nome completo;
    - Descrição;
    - Quantidade de estrelas;
    - Quantidade de forks;
    - Nome do autor;

### Requisitos
    
    Rails 5.2.3
    Ruby 2.5.1

### Setup

- git clone https://github.com/armando-couto/api-search-github.git
- cd api-search-github
- bundle install
- rake db:create db:migrate db:seed
- rails s

### Autenticação com JWT

O JWT é um meio de transmitir informações seguras.

| URL | MÉTODO | RETORNO |
| --- | ------ | ------- |
| /api/v1/auth | POST | Retorno JSON |

Exemplo com curl:

```
curl -X POST \
  http://localhost:3000/api/v1/auth \
  -H 'Content-Type: application/json' \
  -d '{"name": "armando", "password": "123456"}'
```

Exemplo de retorno de json:

```
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c3VhcmlvX2lkIjoxLCJleHAiOjE1NjQ2MjUxOTB9.J_XzUETJomQEWiJWRHNJHLYW7HfIPGOIbG5IIOeNdeg",
    "exp": "07-31-2019 23:06",
    "name": "Armando Couto"
}
```
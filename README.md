# API de Consulta a API do GitHub


### Build Readme

    cd build_readme/
    ruby md2html.rb ../README.md ../public/index.html

### API do GitHub (https://github.com/kristjanjansen/md2html)
    https://developer.github.com/v3/search/#search-repositories

### Demo
    https://api-search-github.herokuapp.com/
    
### Observação

Foi preciso usar a API com o OAUTH-TOKEN.
Por favor ler: https://developer.github.com/v3/#rate-limiting    

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

### Listando todos os repositórios

Foi usada essa API:  https://developer.github.com/v3/repos/#list-all-public-repositories.
Pode começar colocando o next_id como 0. 

| URL | MÉTODO | RETORNO |
| --- | ------ | ------- |
| /api/v1/repositories?next_id=<ID> | GET | Retorno JSON |

Exemplo com curl:

```
curl -X GET \
  http://localhost:3000/api/v1/repositories?next_id=<ID> \
  -H 'Authorization: <TOKEN-GERADO-PELO-JWT>'
```

Exemplo de retorno de json:

```
{
    "data": [
        {
            "full_name": "anotherjesse/fotomatic",
            "description": "Flash photo widget prototype - hacked at last SHDH of 2007",
            "star_count": 10,
            "amount_of_forks": 3,
            "author_name": "anotherjesse"
        },
        ...
    ],
    "pagination": {
        "next_id": 102
    }
}
```






# API de Consulta a API do GitHub


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
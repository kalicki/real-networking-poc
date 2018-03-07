#### BACKEND
- Ruby 2.5.0
- Rails 5

    Instalado via comando: (não precisa executar)
        `rails new backend --api -T -d=postgresql`
    Criado modelos de dados
    ```
    rails g model Company name segment
    
    rails g model User name email
    
    company:references

    docker-compose run --rm backend rake db:create
    
    db:migrate /* com isso irá criar o schema.rb */
    ```
    
    Adicionado na Gemfile 
        `gem 'graphql'` 
        `gem 'graphiql-rails'`
        
    Executado `bundle install`
    - `rails generate graphql:install`
        Com isso foi gerado na pasta `app` ~>
        ``` 
        appgraphql/mutations
        graphql/types
        controllers/graphql_controller.rb
        E atualizou o config/routes.rb
        ```
    - em config/application.rb, adicionar na classe Application isso:
        ```
        config.autoload_paths << Rails.root.join('app/graphql')
        config.autoload_paths << Rails.root.join('app/graphql/types')
        config.autoload_paths << Rails.root.join('app/graphql/mutations')
        ```
        * com isso as rotas disponiveis será somente via GraphQL
    - em graphql/types foi criado user_type.rb e company_type.rb, criado mutation_types 


 ##### DOCKER BACKEND: 
    `docker-compose run --rm backend` 
    `docker-compose up backend` 
    * executa somente o backend em localhost:3000
    * caso tenha erro no activerecord, é recomendando executar db:reset


#### FRONTEND
React > 16

3 - Alterado em config/database.yml o host/database/password

##### DOCKER FRONTEND: 
    `docker-compose run --rm frontend`
    `docker-compose run --rm --service-ports frontend yarn start`
    * service-ports abre a porta configurada, no caso, ':8080'
    docker-compose up frontend
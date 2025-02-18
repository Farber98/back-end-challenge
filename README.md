Desafio back-end AMARO
==========================

## Sobre o desafio

### Criação de API para cadastro e consulta de produtos 

Você precisa criar uma API com os seguintes requisitos:

#### End-point para inserção de dados

* O cliente poderá enviá-los em arquivos json e a API
deverá inserir no banco de dados.
* Escolha o banco de dados que achar melhor.

#### End-point para consulta destes produtos

* Pode ser consultado por: id, nome ou tags. Caso a consulta seja por uma tag ou nome, 
deverá listar todos os produtos com aquela respectiva busca, poderá ser feito em um ou mais end-points.

#### Requisitos Obrigatórios

* Ter uma cobertura de teste relativamente boa, a maior que você conseguir.
* Pode usar qualquer framework.
* Criar um cache para consulta.


#### PLUS - Não necessário

* Colocar uma autenticação.

## Orientações
* Procure fazer uma API sucinta. 
* Os arquivos (json) junto com o formato que o cliente irá enviar estão no repositório.
* Pensa em escalabilidade, pode ser uma quantidade muito grande de dados.
* Coloque isso em um repositório GIT.
* Colocar as orientações de setup no README do seu repositório.

# Boa sorte 

# Solution:

## Setup:
```
$ docker compose build
$ docker compose up
```

Note: To erase volumes.
```
$ docker compose down -v
```

## Stack:
* Go programming language.
* MySQL database.
* go-cache in-memory cache.
* PASETO security token.
* Swagger API documentation.
* Docker setup.

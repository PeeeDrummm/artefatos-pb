*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /produtos
Resource         ../keywords/produtos_keywords.robot
Suite Setup      Criar Sessão

*** Test Cases ***
Cenário: POST Criar Produto 201
    [Tags]    POSTPRODUTO
    Fazer Login e Armazenar Token
    POST Endpoint /produtos
    Validar Status Code "201"

Cenário: DELETE Excluir Produto 200
    [Tags]    DELETEPRODUTO
    Fazer Login e Armazenar Token
    Criar Um Produto e Armazenar ID
    DELETE Endpoint /produtos
    Validar Status Code "200"
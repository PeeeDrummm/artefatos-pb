*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /produtos
Resource         ../resources/produtos_keywords.resource
Resource         ../resources/carrinhos_keywords.resource
Resource         ../resources/login_keywords.resource
Resource         ../resources/usuarios_keywords.resource
Resource         ../variables/env_variables.robot
Suite Setup      Criar Sessão
Test Teardown    Aguardar Delay Global

*** Test Cases ***
Cenário: POST Criar Produto com Token de Admin - 201
    [Tags]    POSTPRODUTO    CT013
    Realizar Login Como Admin
    POST Criar Produto com Token
    Validar Status Code    201

Cenário: POST Criar Produto Sem Token - 401
    [Tags]    POSTPRODUTO    CT014
    POST Criar Produto Sem Token
    Validar Status Code    401

Cenário: POST Criar Produto com Nome Já Existente - 400
    [Tags]    POSTPRODUTO    CT015
    Realizar Login Como Admin
    Gerar Dados de Produto
    POST Criar Produto com Nome Gerado
    POST Criar Produto com Mesmo Nome
    Validar Status Code    400

Cenário: PUT Criar Produto com ID Inexistente - 201
    [Tags]    PUTPRODUTO    CT016
    Realizar Login Como Admin
    Gerar ID Inexistente
    PUT Criar Produto Com ID Inexistente
    Validar Status Code    201

Cenário: PUT Atualizar Produto com Nome Já Existente - 400
    [Tags]    PUTPRODUTO    CT017
    Realizar Login Como Admin
    Criar Produto A
    Criar Produto B
    Tentar Renomear Produto B Com Nome de Produto A
    Validar Status Code    400

Cenário: DELETE Produto Vinculado a Carrinho - 400
    [Tags]    DELETEPRODUTO    CT018
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Criar Produto Para Carrinho
    Criar Carrinho Com Produto    ${id_produto}
    DELETE Produto Vinculado Ao Carrinho
    Validar Status Code    400
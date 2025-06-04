*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /carrinhos
Resource         ../resources/carrinhos_keywords.resource
Resource         ../resources/usuarios_keywords.resource
Resource         ../resources/login_keywords.resource
Resource         ../resources/produtos_keywords.resource
Resource         ../variables/env_variables.robot
Suite Setup      Criar Sessão
Test Teardown    Aguardar Delay Global

*** Test Cases ***
Cenário: POST Criar Carrinho com Token Válido - 201
    [Tags]    POSTCARRINHO    CT019
    [Teardown]    Cancelar Carrinho
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Criar Produto Para Carrinho
    Criar Carrinho Com Produto    ${id_produto}
    Validar Status Code    201

Cenário: POST Criar Carrinho com Produto Inexistente - 400
    [Tags]    POSTCARRINHO    CT020
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Gerar ID Inexistente
    Criar Carrinho Com Produto Inexistente
    Validar Status Code    400

Cenário: POST Criar Carrinho com Produto Duplicado - 400
    [Tags]    POSTCARRINHO    CT021
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Criar Produto Para Carrinho
    Criar Carrinho Com Produto Duplicado
    Validar Status Code    400

Cenário: POST Criar Segundo Carrinho para o Mesmo Usuário - 400
    [Tags]    POSTCARRINHO    CT022
    [Teardown]    Cancelar Carrinho
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Criar Produto Para Carrinho
    Criar Carrinho Com Produto    ${id_produto}
    Criar Carrinho Com Produto    ${id_produto}
    Validar Status Code    400

Cenário: DELETE Cancelar Carrinho - 200
    [Tags]    DELETECARRINHO    CT023
    [Teardown]    Cancelar Carrinho
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Criar Produto Para Carrinho
    Criar Carrinho Com Produto    ${id_produto}
    Cancelar Carrinho
    Validar Status Code    200

Cenário: DELETE Concluir Compra - 200
    [Tags]    DELETECARRINHO    CT024
    Criar Usuário Dinâmico
    Realizar Login Com Usuário Dinâmico
    Criar Produto Para Carrinho
    Criar Carrinho Com Produto    ${id_produto}
    Concluir Compra
    Validar Status Code    200
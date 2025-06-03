*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /login
Resource         ../resources/login_keywords.resource
Resource         ../resources/produtos_keywords.resource
Resource         ../variables/env_variables.robot
Suite Setup      Criar Sessão
Test Teardown    Sleep    ${global_delay}

*** Test Cases ***
Cenário: POST Realizar Login com Dados Válidos - 200
    [Tags]    POSTLOGIN    CT009
    POST Endpoint /login
    Validar Status Code    200
    Validar Ter Logado
    Armazenar Token de Autenticação

Cenário: POST Login com Senha Incorreta - 401
    [Tags]    POSTLOGIN    CT010
    POST Endpoint /login com Senha Incorreta
    Validar Status Code    401
    Validar Mensagem de Erro Login    Email e/ou senha inválidos

Cenário: POST Login com Usuário Inexistente - 401
    [Tags]    POSTLOGIN    CT011
    POST Endpoint /login com Usuario Inexistente
    Validar Status Code    401
    Validar Mensagem de Erro Login    Email e/ou senha inválidos
############### DEIXAR POR ÚLTIMO ###############
Cenário: Token Expirado Após Login - 401
    [Tags]    POSTLOGIN    CT012
    Realizar Login Como Admin
    Esperar Expiração do Token
    POST Criar Produto com Token
    Validar Status Code    401
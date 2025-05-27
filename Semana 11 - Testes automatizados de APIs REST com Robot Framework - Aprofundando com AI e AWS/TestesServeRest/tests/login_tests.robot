*** Settings ***
Documentation    Arquivo de Testes para o Endpoint /login
Resource         ../keywords/login.keywords.robot
Suite Setup      Criar Sessão

*** Test Cases ***
Cenário: POST Realizar Login 200
    [Tags]    POSTLOGIN
    POST Endpoint /login
    Validar Status Code "200"